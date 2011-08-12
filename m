Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QrfNF-0007qL-6s
	for kexec@lists.infradead.org; Fri, 12 Aug 2011 00:13:18 +0000
Date: Fri, 12 Aug 2011 09:08:25 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 5/8] makedumpfile: Read and process filter commands
	from config file.
Message-Id: <20110812090825.962639ba.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E43BDF2.8030609@linux.vnet.ibm.com>
References: <20110517200407.12740.95780.stgit@mars.in.ibm.com>
	<20110811110716.7aec3c9e.oomichi@mxs.nes.nec.co.jp>
	<4E43BDF2.8030609@linux.vnet.ibm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

Thank you for checking the above also.
commit 92d2934f9e1694e7195d93f9816fbea8a657f05f fixes them.


Thanks
Ken'ichi Ohmichi

On Thu, 11 Aug 2011 17:03:06 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>
> Hi Ken'ichi,
> 
> On 08/11/2011 07:37 AM, Ken'ichi Ohmichi wrote:
> > 
> > Hi Mahesh,
> > 
> > On Wed, 18 May 2011 01:34:15 +0530
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >>
> >> This patch enables to makedumpfile to read and process filter commands from
> >> specified config file. It builds a list of filter info consisting of memory
> >> address (paddr) and size to be filtered out. This list is used during
> >> read_pfn() function to filter out user specified kernel data from vmcore
> >> before writing it to compressed DUMPFILE. The filtered memory locations are
> >> filled with 'X' (0x58) character.
> >>
> >> The filter command syntax is:
> >> 	erase <Symbol>[.member[...]] [size <SizeValue>[K|M]]
> >> 	erase <Symbol>[.member[...]] [size <SizeSymbol>]
> >> 	erase <Symbol>[.member[...]] [nullify]
> >>
> >> Below are the examples how filter commands in config file look like:
> >>
> >> 	erase modules
> >> 	erase cred_jar.name size 10
> >> 	erase vmlist.addr nullify
> > 
> > Thank you for the work.
> > I tested this feature by the above example, and confirmed the feature
> > works fine. Nice work :-)
> 
> Thanks :-)
> 
> > 
> > There are some comments in the below lines.
> > Can you check them ?
> > 
> >> +/*
> >> + * Read the non-terminal's which are in the form of <Symbol>[.member[...]]
> >> + */
> >> +struct config_entry *
> >> +create_config_entry(const char *token, unsigned short flag, int line)
> >> +{
> >> +	struct config_entry *ce = NULL, *ptr, *prev_ce;
> >> +	char *str, *cur, *next;
> >> +	long len;
> >> +	int depth = 0;
> >> +
> >> +	if (!token)
> >> +		return NULL;
> >> +
> >> +	cur = str = strdup(token);
> >> +	prev_ce = ptr = NULL;
> >> +	while (cur != NULL) {
> >> +		if ((next = strchr(cur, '.')) != NULL) {
> >> +			*next++ = '\0';
> >> +		}
> >> +		if (!strlen(cur)) {
> >> +			cur = next;
> >> +			continue;
> >> +		}
> >> +
> >> +		if ((ptr = calloc(1, sizeof(struct config_entry))) == NULL) {
> >> +			ERRMSG("Can't allocate memory for config_entry\n");
> >> +			goto err_out;
> >> +		}
> >> +		ptr->line = line;
> >> +		ptr->flag |= flag;
> >> +		if (depth == 0) {
> >> +			/* First node is always a symbol name */
> >> +			ptr->flag |= SYMBOL_ENTRY;
> >> +		}
> >> +		if (flag & FILTER_ENTRY) {
> >> +			ptr->name = strdup(cur);
> >> +		}
> >> +		if (flag & SIZE_ENTRY) {
> >> +			char ch = '\0';
> >> +			int n = 0;
> >> +			/* See if absolute length is provided */
> >> +			if ((depth == 0) &&
> >> +				((n = sscanf(cur, "%zd%c", &len, &ch)) > 0)) {
> >> +				if (len < 0) {
> >> +					ERRMSG("Config error at %d: size "
> >> +						"value must be positive.\n",
> >> +						line);
> >> +					goto err_out;
> >> +				}
> >> +				ptr->size = len;
> >> +				ptr->flag |= ENTRY_RESOLVED;
> >> +				if (n == 2) {
> >> +					/* Handle suffix.
> >> +					 * K = Kilobytes
> >> +					 * M = Megabytes
> >> +					 */
> >> +					switch (ch) {
> >> +					case 'M':
> >> +					case 'm':
> >> +						ptr->size *= 1024;
> >> +					case 'K':
> >> +					case 'k':
> >> +						ptr->size *= 1024;
> >> +						break;
> >> +					}
> >> +				}
> >> +			}
> >> +			else
> >> +				ptr->name = strdup(cur);
> >> +		}
> >> +		if (prev_ce) {
> >> +			prev_ce->next = ptr;
> >> +			prev_ce = ptr;
> >> +		}
> >> +		else
> >> +			ce = prev_ce = ptr;
> >> +		cur = next;
> >> +		depth++;
> >> +		ptr = NULL;
> >> +	}
> >> +	free(str);
> >> +	return ce;
> >> +
> >> +err_out:
> >> +	if (ce)
> >> +		free_config_entry(ce);
> >> +	if (ptr)
> >> +		free_config_entry(ptr);
> > 
> > "free(str);" is necessary.
> > 
> 
> Nice catch. Agree.
> 
> >> +	return NULL;
> >> +}
> > 
> > [..]
> > 
> >> +/*
> >> + * read filter config file and return each string token. If the parameter
> >> + * expected_token is non-NULL, then return the current token if it matches
> >> + * with expected_token otherwise save the current token and return NULL.
> >> + * At start of every module section filter_config.new_section is set to 1 and
> >> + * subsequent function invocations return NULL untill filter_config.new_section
> >> + * is reset to 0 by passing @flag = CONFIG_NEW_CMD (0x02).
> >> + *
> >> + * Parameters:
> >> + * @expected_token	INPUT
> >> + *	Token string to match with currnet token.
> >> + *	=NULL - return the current available token.
> >> + *
> >> + * @flag		INPUT
> >> + *	=0x01 - Skip to next module section.
> >> + *	=0x02 - Treat the next token as next filter command and reset.
> >> + *
> >> + * @line		OUTPUT
> >> + *	Line number of current token in filter config file.
> >> + *
> >> + * @cur_mod		OUTPUT
> >> + *	Points to current module section name on non-NULL return value.
> >> + *
> >> + * @eof			OUTPUT
> >> + *	set to -1 when end of file is reached.
> >> + *	set to -2 when end of section is reached.
> >> + */
> >> +static char *
> >> +get_config_token(char *expected_token, unsigned char flag, int *line,
> >> +			char **cur_mod, int *eof)
> >> +{
> >> +	char *p;
> >> +	struct filter_config *fc = &filter_config;
> >> +	int skip = flag & CONFIG_SKIP_SECTION;
> > 
> > CONFIG_SKIP_SECTION is used only here, and we need to fix get_config()
> > for the readability. Please check my comment in get_config().
> > 
> > [..]
> > 
> >> +/*
> >> + * Configuration file 'makedumpfile.conf' contains filter commands.
> >> + * Every individual filter command is considered as a config entry. A config
> >> + * entry can be provided on a single line or multiple lines.
> >> + */
> >> +struct config *
> >> +get_config(int skip)
> >> +{
> >> +	struct config *config;
> >> +	char *token = NULL;
> >> +	static int line_count = 0;
> >> +	char *cur_module = NULL;
> >> +	int eof = 0;
> >> +	unsigned char flag = CONFIG_NEW_CMD | skip;
> > 
> > We need to change the above:
> > 
> > 	unsigned char flag = CONFIG_NEW_CMD;
> > 	if (skip)
> > 		flag |= CONFIG_SKIP_SECTION;
> >
> 
> Agree.
> 
> Thanks,
> -Mahesh.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
