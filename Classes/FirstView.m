//
//  FirstView.m
//  WindowTabBar
//
//  Created by zaab on 04/011/10.
//  Copyright fizaboun 2010. All rights reserved.
//

#import "FirstView.h"
#import "TableViewDetailViewController.h"

#define USE_CUSTOM_DRAWING 1


@implementation FirstView

@synthesize itemsList;
@synthesize totalList;
@synthesize myTableView;
@synthesize imageView;


- (void)viewDidLoad
{
	myTableView.rowHeight = 100;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [itemsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	
#if USE_CUSTOM_DRAWING
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	UILabel *topLabel;
	UILabel *bottomLabel;
#endif
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		//
		// Create the cell.
		//
		cell =
		[[[UITableViewCell alloc]
		  initWithFrame:CGRectZero
		  reuseIdentifier:CellIdentifier]
		 autorelease];
		
#if USE_CUSTOM_DRAWING
		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
		cell.accessoryView = [[[UIImageView alloc]initWithImage:indicatorImage]autorelease];
		
		const CGFloat LABEL_HEIGHT = 20;
		
		//
		// Create the label for the top row of text
		//
		topLabel =
		[[[UILabel alloc]
		  initWithFrame:
		  CGRectMake(
					 2.0 * cell.indentationWidth,
					 0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT),
					 tableView.bounds.size.width -
					4.0 * cell.indentationWidth
					 - indicatorImage.size.width,
					 LABEL_HEIGHT)]
		 autorelease];
		[cell.contentView addSubview:topLabel];
		
		//
		// Configure the properties for the text that are the same on every row
		//
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
		
		//
		// Create the label for the top row of text
		//
		bottomLabel = [[[UILabel alloc]initWithFrame:
		  CGRectMake(2.0 * cell.indentationWidth,
					 0.5 * (tableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT,
					 tableView.bounds.size.width- 4.0*cell.indentationWidth- indicatorImage.size.width,
					 LABEL_HEIGHT)]
		 autorelease];
		[cell.contentView addSubview:bottomLabel];
		
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
		
		//
		// Create a background image view.
		//
		cell.backgroundView = [[[UIImageView alloc] init] autorelease];
		cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
#endif
	}
	
#if USE_CUSTOM_DRAWING
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}
	
	topLabel.text = [itemsList objectAtIndex:indexPath.row];
	//bottomLabel.text = [NSString stringWithFormat:@"Some other information.", [indexPath row]];
	
	//
	// Set the background and selected background images for the text.
	// Since we will round the corners at the top and bottom of sections, we
	// need to conditionally choose the images based on the row index and the
	// number of rows in the section.
	//
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"topAndBottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
	}
	else if (row == 0)
	{
		rowBackground = [UIImage imageNamed:@"topRow.png"];
		selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"bottomRow.png"];
		selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
	}
	else
	{
		rowBackground = [UIImage imageNamed:@"middleRow.png"];
		selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;

#endif
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	TableViewDetailViewController *fvController = [[TableViewDetailViewController alloc] initWithNibName:@"TableViewDetailViewController" bundle:[NSBundle mainBundle]];
	fvController.selectVerb1 = [itemsList objectAtIndex:[indexPath row]];
	fvController.selectVerb2 = [totalList objectAtIndex:indexPath.row+373];
	fvController.selectVerb3 = [totalList objectAtIndex:indexPath.row+746];

	[self.navigationController pushViewController:fvController animated:YES];
	[fvController release];
	fvController = nil;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) tableView:(UITableView *)tableView deselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)loadView{
		
	myTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	myTableView.delegate = self;
	myTableView.dataSource = self;
    [myTableView setBackgroundColor:[UIColor blackColor]];
	myTableView.separatorColor = [UIColor clearColor];
	myTableView.autoresizesSubviews = YES;
	
	itemsList = [[NSArray alloc] initWithObjects:@"arise", @"awake", @"backslide", @"be", @"bear", @"beat", @"become", @"begin", @"bend", @"bet", @"bid (farewell)", 
				 @"bid (offer amount)", @"bind", @"bite", @"bleed", @"blow", @"break", @"breed", @"bring", @"broadcast", @"browbeat", @"build", @"burn", @"burst",
				 @"bust", @"buy",@"cast",@"catch",@"choose",@"cling",@"clothe",@"come",@"cost",@"creep",@"crossbreed",@"cut",@"daydream",@"deal",@"dig",@"disprove",
				 @"dive (jump head-first)",@"dive (scuba diving)",@"do",@"draw",@"dream",@"drink",@"drive",@"dwell",@"eat",@"fall",@"feed",@"feel",@"fight",@"find",
				 @"fit (tailor, change size)",@"fit (be right size)",@"flee",@"fling",@"fly",@"forbid",@"forecast",@"forego (also forgo)",@"foresee",@"foretell",
				 @"forget",@"forgive",@"forsake",@"freeze",@"frostbite",@"get",@"give",@"go",@"grind",@"grow",@"hand-feed",@"handwritte",@"hang",@"have",@"hear",
				 @"hew",@"hide",@"hit",@"hold",@"hurt",@"inbreed",@"inlay",@"input",@"interbreed",@"interweave",@"interwind",@"jerry-build",@"keep",@"kneel",@"knit",
				 @"know",@"lay",@"lead",@"lean",@"leap",@"learn",@"leave",@"lend",@"let",@"lie",@"lie (not tell truth) REGULAR",@"light",@"lip-read",@"lose",@"make",
				 @"mean",@"meet",@"miscast",@"misdeal",@"misdo",@"mishear",@"mislay",@"mislead",@"mislearn",@"misread",@"misset",@"misspeak",@"misspell",@"misspend",
				 @"mistake",@"misteach",@"misunderstand",@"miswrite",@"mow",@"offset",@"outbid",@"outbreed",@"outdo",@"outdraw",@"outdrink",@"outdrive",@"outfight",
				 @"outfly",@"outgrow",@"outleap",@"outlie (not tell truth) REGULAR",@"outride",@"outrun",@"outsell",@"outshine",@"outshoot",@"outsing",@"outsit",
				 @"outsleep",@"outsmell",@"outspeak",@"outspeed",@"outspend",@"outswear",@"outswim",@"outthink",@"outthrow",@"outwrite",@"overbid",@"overbreed",
				 @"overbuild",@"overbuy",@"overcome",@"overdo",@"overdraw",@"overdrink",@"overeat",@"overfeed",@"overhang",@"overhear",@"overlay",@"overpay",
				 @"override",@"overrun",@"oversee",@"oversell",@"oversew",@"overshoot",@"oversleep",@"overspeak",@"overspend",@"overspill",@"overtake",@"overthink",
				 @"overthrow",@"overwind",@"overwrite",@"partake",@"pay",@"plead",@"prebuild",@"predo",@"premake",@"prepay",@"presell",@"preset",@"preshrink",
				 @"proofread",@"prove",@"put",@"quick-freeze",@"quit",@"read",@"reawake",@"rebid",@"rebind",@"rebroadcast",@"rebuild",@"recast",@"recut",@"redeal",
				 @"redo",@"redraw",@"refit (replace parts)",@"refit (retailor)",@"regrind",@"regrow",@"rehang",@"rehear",@"reknit",@"relay (for example tiles)",
				 @"relay (pass along) REGULAR",@"relearn",@"relight",@"remake",@"repay",@"reread",@"rerun",@"resell",@"resend",@"reset",@"resew",@"retake",@"reteach",
				 @"retear",@"retell",@"rethink",@"retread",@"retrofit",@"rewake",@"rewear",@"reweave",@"rewed",@"rewet",@"rewin",@"rewind",@"rewrite",@"rid",@"ride",
				 @"ring",@"rise",@"roughcast",@"run",@"sand-cast",@"saw",@"say",@"see",@"seek",@"sell",@"send",@"set",@"sew",@"shake",@"shave",@"shear",@"shed",
				 @"shine",@"shit",@"shoot",@"show",@"shrink",@"shut",@"sight-read",@"sing",@"sink",@"sit",@"slay (kill)",@"slay (amuse) REGULAR",@"sleep",@"slide",
				 @"sling",@"slink",@"slit",@"smell",@"sneak",@"sow",@"speak",@"speed",@"spell",@"spend",@"spill",@"spin",@"spit",@"split",@"spoil",@"spoon-feed",
				 @"spread",@"spring",@"stand",@"steal",@"stick",@"sting",@"stink",@"strew",@"stride",@"strike (delete)",@"strike (hit)",@"string",@"strive",@"sublet",
				 @"sunburn",@"swear",@"sweat",@"sweep",@"swell",@"swim",@"swing",@"take",@"teach",@"tear",@"telecast",@"tell",@"test-drive",@"test-fly",@"think",
				 @"throw",@"thrust",@"tread",@"typecast",@"typeset",@"typewrite",@"unbend",@"unbind",@"unclothe",@"underbid",@"undercut",@"underfeed",@"undergo",
				 @"underlie",@"undersell",@"underspend",@"understand",@"undertake",@"underwrite",@"undo",@"unfreeze",@"unhang",@"unhide",@"unknit",@"unlearn",@"unsew",
				 @"unsling",@"unspin",@"unstick",@"unstring",@"unweave",@"unwind",@"uphold",@"upset",@"wake",@"waylay",@"wear",@"weave",@"wed",@"weep",@"wet",
				 @"whet  REGULAR",@"win",@"wind",@"withdraw",@"withhold",@"withstand",@"wring",@"write",nil];

	totalList = [[NSArray alloc] initWithObjects:@"arise", @"awake", @"backslide", @"be", @"bear", @"beat", @"become", @"begin", @"bend", @"bet", @"bid (farewell)", 
				 @"bid (offer amount)", @"bind", @"bite", @"bleed", @"blow", @"break", @"breed", @"bring", @"broadcast", @"browbeat", @"build", @"burn", @"burst", 
				 @"bust", @"buy",@"cast",@"catch",@"choose",@"cling",@"clothe",@"come",@"cost",@"creep",@"crossbreed",@"cut",@"daydream",@"deal",@"dig",@"disprove",
				 @"dive (jump head-first)",@"dive (scuba diving)",@"do",@"draw",@"dream",@"drink",@"drive",@"dwell",@"eat",@"fall",@"feed",@"feel",@"fight",
				 @"find",@"fit (tailor, change size)",@"fit (be right size)",@"flee",@"fling",@"fly",@"forbid",@"forecast",@"forego (also forgo)",@"foresee",
				 @"foretell",@"forget",@"forgive",@"forsake",@"freeze",@"frostbite", @"get",@"give",@"go",@"grind",@"grow",@"hand-feed",@"handwritte",@"hang",
				 @"have",@"hear",@"hew",@"hide",@"hit",@"hold",@"hurt",@"inbreed",@"inlay",@"input",@"interbreed",@"interweave",@"interwind",@"jerry-build",@"keep",
				 @"kneel",@"knit",@"know",@"lay",@"lead",@"lean",@"leap",@"learn",@"leave",@"lend",@"let",@"lie",@"lie (not tell truth) REGULAR",@"light",@"lip-read",@"lose",@"make",
				 @"mean",@"meet",@"miscast",@"misdeal",@"misdo",@"mishear",@"mislay",@"mislead",@"mislearn",@"misread",@"misset",@"misspeak",@"misspell",@"misspend",
				 @"mistake",@"misteach",@"misunderstand",@"miswrite",@"mow",@"offset",@"outbid",@"outbreed",@"outdo",@"outdraw",@"outdrink",@"outdrive",@"outfight",
				 @"outfly",@"outgrow",@"outleap",@"outlie (not tell truth) REGULAR",@"outride",@"outrun",@"outsell",@"outshine",@"outshoot",@"outsing",@"outsit",
				 @"outsleep",@"outsmell",@"outspeak",@"outspeed",@"outspend",@"outswear",@"outswim",@"outthink",@"outthrow",@"outwrite",@"overbid",@"overbreed",
				 @"overbuild",@"overbuy",@"overcome",@"overdo",@"overdraw",@"overdrink",@"overeat",@"overfeed",@"overhang",@"overhear",@"overlay",@"overpay",
				 @"override",@"overrun",@"oversee",@"oversell",@"oversew",@"overshoot",@"oversleep",@"overspeak",@"overspend",@"overspill",@"overtake",@"overthink",
				 @"overthrow",@"overwind",@"overwrite",@"partake",@"pay",@"plead",@"prebuild",@"predo",@"premake",@"prepay",@"presell",@"preset",@"preshrink",
				 @"proofread",@"prove",@"put",@"quick-freeze",@"quit",@"read",@"reawake",@"rebid",@"rebind",@"rebroadcast",@"rebuild",@"recast",@"recut",@"redeal",
				 @"redo",@"redraw",@"refit (replace parts)",@"refit (retailor)",@"regrind",@"regrow",@"rehang",@"rehear",@"reknit",@"relay (for example tiles)",
				 @"relay (pass along) REGULAR",@"relearn",@"relight",@"remake",@"repay",@"reread",@"rerun",@"resell",@"resend",@"reset",@"resew",@"retake",@"reteach",
				 @"retear",@"retell",@"rethink",@"retread",@"retrofit",@"rewake",@"rewear",@"reweave",@"rewed",@"rewet",@"rewin",@"rewind",@"rewrite",@"rid",@"ride",
				 @"ring",@"rise",@"roughcast",@"run",@"sand-cast",@"saw",@"say",@"see",@"seek",@"sell",@"send",@"set",@"sew",@"shake",@"shave",@"shear",@"shed",
				 @"shine",@"shit",@"shoot",@"show",@"shrink",@"shut",@"sight-read",@"sing",@"sink",@"sit",@"slay (kill)",@"slay (amuse) REGULAR",@"sleep",@"slide",
				 @"sling",@"slink",@"slit",@"smell",@"sneak",@"sow",@"speak",@"speed",@"spell",@"spend",@"spill",@"spin",@"spit",@"split",@"spoil",@"spoon-feed",
				 @"spread",@"spring",@"stand",@"steal",@"stick",@"sting",@"stink",@"strew",@"stride",@"strike (delete)",@"strike (hit)",@"string",@"strive",@"sublet",
				 @"sunburn",@"swear",@"sweat",@"sweep",@"swell",@"swim",@"swing",@"take",@"teach",@"tear",@"telecast",@"tell",@"test-drive",@"test-fly",@"think",
				 @"throw",@"thrust",@"tread",@"typecast",@"typeset",@"typewrite",@"unbend",@"unbind",@"unclothe",@"underbid",@"undercut",@"underfeed",@"undergo",
				 @"underlie",@"undersell",@"underspend",@"understand",@"undertake",@"underwrite",@"undo",@"unfreeze",@"unhang",@"unhide",@"unknit",@"unlearn",@"unsew",
				 @"unsling",@"unspin",@"unstick",@"unstring",@"unweave",@"unwind",@"uphold",@"upset",@"wake",@"waylay",@"wear",@"weave",@"wed",@"weep",@"wet",
				 @"whet  REGULAR",@"win",@"wind",@"withdraw",@"withhold",@"withstand",@"wring",@"write", 
				 
				 
				 @"arose", @"awakened",@"backslid",@"was",@"bore",@"beat", @"became",
				 @"began",@"bent",@"bet",@"bid ",@"bid",@"bound",@"bit",@"bled",@"blew",@"broke",@"bred",@"brought",@"broadcast / broadcasted",@"browbeat",
				 @"built",@"burned",@"burst",@"busted ",@"bought",@"cast",@"caught",@"chose",@"clung",@"clothed ",@"came",@"cost",@"crept",
				 @"crossbred",@"cut",@"daydreamed",@"dealt",@"dug",@"disproved",@"dove",@"dove",@"did",@"drew",@"dreamed",@"drank",@"drove",@"dwelt",
				 @"ate",@"fel",@"fed",@"felt",@"fought",@"found",@"fitted",@"fitted",@"fled",@"flung",@"flew",@"forbade",@"forecast",@"forewent",@"foresaw",
				 @"foretold",@"forgot",@"forgave",@"forsook",@"froze",@"frostbit",@"got",@"gave",@"went",@"ground",@"grew",@"hand-fed",@"handwrotte",@"hung",@"had",@"heard",@"hewed",@"hid",@"hit",@"held",
				 @"hurt",@"inbred",@"inlaid",@"input",@"interbred",@"interwove",@"interwound",@"jerry-built",@"kept",@"knelt",@"knitted",@"knew",@"laid",@"led",@"leaned",@"leaped",@"learned",@"left",@"lent",@"let",@"lay",@"lied",@"lit",@"lip-read",@"lost",@"made",@"meant",@"met",@"miscast",@"misdealt",@"misdid",@"misheard",@"mislaid",@"misled",@"mislearned",@"misread",@"misset",@"misspoke",@"misspelled ",@"misspent",@"mistook",@"mistaught",@"misunderstood",@"miswrote",@"mowed",@"offset",@"outbid",@"outbred",@"outdid",@"outdrew",@"outdrank",@"outdrove",@"outfought",@"outflew",@"outgrew",@"outleaped",@"outlied",@"outrode",@"outran",@"outsold",@"outshined",@"outshot",@"outsang",@"outsat",@"outslept",@"outsmelled",@"outspoke",@"outsped",@"outspent",@"outswore",@"outswam",@"outthought",@"outthrew",@"outwrote",@"overbid",@"overbred",@"overbuilt",@"overbought",@"overcame",@"overdid",@"overdrew",@"overdrank",@"overate",@"overfed",@"overhung",@"overheard",@"overlaid",@"overpaid",@"overrode",@"overran",@"oversaw",@"oversold",@"oversewed",@"overshot",@"overslept",@"overspoke",@"overspent",@"overspilled",@"overtook",@"overthought",@"overthrew",@"overwound",@"overwrote",@"partook",@"paid",@"pleaded",@"prebuilt",@"predid",@"premade",@"prepaid",@"presold",@"preset",@"preshrank",@"proofread",@"proved",@"put",@"quick-froze",@"quit",@"read",@"reawoke",@"rebid",@"rebound",@"rebroadcast",@"rebuilt",@"recast",@"recut",@"redealt",@"redid",@"redrew",@"refit",@"refitted",@"reground",@"regrew",@"rehung",@"reheard",@"reknitted",@"relaid",@"relayed",@"relearned",@"relit",@"remade",@"repaid",@"reread",@"reran",@"resold",@"resent",@"reset",@"resewed",@"retook",@"retaught",@"retore",@"retold",@"rethought",@"retread",@"retrofitted",@"rewoke",@"rewore",@"rewove",@"rewed",@"rewet",@"rewon",@"rewound",@"rewrote",@"rid",@"rode",@"rang",@"rose",@"roughcast",@"ran",@"sand-cast",@"sawed",@"said",@"saw",@"sought",@"sold",@"sent",@"set",@"sewed",@"shook",@"shaved",@"sheared",@"shed",@"shined",@"shit",@"shot",@"showed",@"shrank",@"shut",@"sight-read",@"sang",@"sank",@"sat",@"slew",@"slayed",@"slept",@"slid",@"slung",@"slinked",@"slit",@"smelled",@"sneaked",@"sowed",@"spoke",@"sped",@"spelled",@"spent",@"spilled",@"spun",@"spit",@"split",@"spoiled",@"spoon-fed",@"spread",@"sprang",@"stood",@"stole",@"stuck",@"stung",@"stunk",@"strewed",@"strode",@"struck",@"struck",@"strung",@"strove",@"sublet",@"sunburned",@"swore",@"sweat",@"swept",@"swelled",@"swam",@"swung",@"took",@"taught",@"tore",@"telecast",@"told",@"test-drove",@"test-flew",@"thought",@"threw",@"thrust",@"trod",@"typecast",@"typeset",@"typewrote",@"unbent",@"unbound",@"unclothed",@"underbid",@"undercut",@"underfed",@"underwent",@"underlay",@"undersold",@"underspent",@"understood",@"undertook",@"underwrote",@"undid",@"unfroze",@"unhung",@"unhid",@"unknitted",@"unlearned",@"unsewed",@"unslung",@"unspun",@"unstuck",@"unstrung",@"unwove",@"unwound",@"upheld",@"upset",@"woke",@"waylaid",@"wore",@"wove",@"wed",@"wept",@"wet",@"whetted",@"won",@"wound",@"withdrew",@"withheld",@"withstood",@"wrung",@"wrote",
 
				 
				 @"arisen",@"awoken",@"backslid",@"been",@"born",@"beaten",@"become",@"begun",@"bent",@"bet",@"bidden",@"bid",@"bound",@"bitten",@"bled",@"blown",@"broken",@"bred",@"brought",@"broadcast",@"browbeaten",@"built",@"burned",@"burst",@"busted",@"bought",@"cast",@"caught",@"chosen",@"clung",@"clothed",@"come",@"cost",@"crept",@"crossbred",@"cut",@"daydreamed",@"dealt",@"dug",@"disproved",@"dived",@"dived",@"done",@"drawn",@"dreamt",@"drunk",@"driven",@"dwelt",@"eaten",@"fallen",@"fed",@"felt",@"fought",@"found",@"fitted",@"fit",@"fled",@"flung",@"flown",@"forbidden",@"forecast",@"foregone",@"foreseen",@"foretold",@"forgot",@"forgiven",@"forsaken",@"frozen",@"frostbitten",@"gotten",@"given",@"gone",@"ground",@"grown",@"hand-fed",@"handwritten",@"hung",@"had",@"heard",@"hewn",@"hidden",@"hit",@"held",@"hurt",@"inbred",@"inlaid",@"input",@"interbred",@"interwoven",@"interwound",@"jerry-built",@"kept",@"knelt",@"knitted",@"known",@"laid",@"led",@"leaned",@"leaped",@"learned",@"left",@"lent",@"let",@"lain",@"lied",@"lit",@"lip-read",@"lost",@"made",@"meant",@"met",@"miscast",@"misdealt",@"misdone",@"misheard",@"mislaid",@"misled",@"mislearned",@"misread",@"misset",@"misspoken",@"misspelled",@"misspent",@"mistaken",@"mistaught",@"misunderstood",@"miswritten",@"mowed",@"offset",@"outbid",@"outbred",@"outdone",@"outdrawn",@"outdrunk",@"outdriven",@"outfought",@"outflown",@"outgrown",@"outleaped",@"outlied",@"outridden",@"outrun",@"outsold",@"outshined",@"outshot",@"outsung",@"outsat",@"outslept",@"outsmelled",@"outspoken",@"outsped",@"outspent",@"outsworn",@"outswum",@"outthought",@"outthrown",@"outwritten",@"overbid",@"overbred",@"overbuilt",@"overbought",@"overcome",@"overdone",@"overdrawn",@"overdrunk",@"overeaten",@"overfed",@"overhung",@"overheard",@"overlaid",@"overpaid",@"overridden",@"overrun",@"overseen",@"oversold",@"oversewn",@"overshot",@"overslept",@"overspoken",@"overspent",@"overspilled",@"overtaken",@"overthought",@"overthrown",@"overwound",@"overwritten",@"partaken",@"paid",@"pleaded",@"prebuilt",@"predone",@"premade",@"prepaid",@"presold",@"preset",@"preshrunk",@"proofread",@"proven / proved",@"put",@"quick-frozen",@"quit",@"read",@"reawaken",@"rebid",@"rebound",@"rebroadcast",@"rebuilt",@"recast",@"recut",@"redealt",@"redone",@"redrawn",@"refit",@"refitted",@"reground",@"regrown",@"rehung",@"reheard",@"reknitted",@"relaid",@"relayed",@"relearned",@"relit",@"remade",@"repaid",@"reread",@"rerun",@"resold",@"resent",@"reset",@"resewn",@"retaken",@"retaught",@"retorn",@"retold",@"rethought",@"retread",@"retrofitted",@"rewaken",@"reworn",@"rewoven",@"rewed",@"rewet",@"rewon",@"rewound",@"rewritten",@"rid",@"ridden",@"rung",@"risen",@"roughcast",@"run",@"sand-cast",@"sawed",@"said",@"seen",@"sought",@"sold",@"sent",@"set",@"sewn",@"shaken",@"shaved",@"sheared",@"shed",@"shined",@"shit",@"shot",@"shown",@"shrunk",@"shut",@"sight-read",@"sung",@"sunk",@"sat",@"slain",@"slayed",@"slept",@"slid",@"slung",@"slinked / slunk",@"slit",@"smelt",@"sneaked",@"sown",@"spoken",@"sped",@"spelled ",@"spent",@"spilled",@"spun",@"spit",@"split",@"spoiled",@"spoon-fed",@"spread",@"sprung",@"stood",@"stolen",@"stuck",@"stung",@"stunk",@"strewn",@"stridden",@"stricken",@"struck",@"strung",@"striven",@"sublet",@"sunburned",@"sworn",@"sweat",@"swept",@"swollen",@"swum",@"swung",@"taken",@"taught",@"torn",@"telecast",@"told",@"test-driven",@"test-flown",@"thought",@"thrown",@"thrust",@"trodden",@"typecast",@"typeset",@"typewritten",@"unbent",@"unbound",@"unclothed",@"underbid",@"undercut",@"underfed",@"undergone",@"underlain",@"undersold",@"underspent",@"understood",@"undertaken",@"underwritten",@"undone",@"unfrozen",@"unhung",@"unhidden",@"unknitted",@"unlearned",@"unsewn",@"unslung",@"unspun",@"unstuck",@"unstrung",@"unwoven",@"unwound",@"upheld",@"upset",@"woken",@"waylaid",@"worn",@"woven",@"wed",@"wept",@"wet",@"whetted",@"won",@"wound",@"withdrawn",@"withheld",@"withstood",@"wrung",@"written",
				 
				 nil];

	
	self.navigationItem.title = @"Verbs List";
	self.view = myTableView;
	
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[itemsList release];
	[totalList release];
    [super dealloc];
}


@end






