Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUz1x-0004hK-EU
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 07:15:30 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8B6GeOR020240
	for <kexec@lists.infradead.org>; Tue, 11 Sep 2007 02:16:40 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8B6FEFN542150
	for <kexec@lists.infradead.org>; Tue, 11 Sep 2007 02:15:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8B6FER3026338
	for <kexec@lists.infradead.org>; Tue, 11 Sep 2007 02:15:14 -0400
Date: Tue, 11 Sep 2007 11:45:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 1/5] Extended crashkernel command line
Message-ID: <20070911061522.GD5053@in.ibm.com>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.488571169@strauss.suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070909083914.488571169@strauss.suse.de>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Sun, Sep 09, 2007 at 10:39:15AM +0200, Bernhard Walle wrote:

[..]
> +
> +/*
> + * parsing the "crashkernel" commandline
> + *
> + * this code is intended to be called from architecture specific code
> + */
> +
> +
> +/*
> + * This function parses command lines in the format
> + *
> + *   crashkernel=<ramsize-range>:<size>[,...][@<base>]
> + *
> + * The function returns 0 on success and -EINVAL on failure.
> + */
> +static int parse_crashkernel_mem(char 			*cmdline,
> +				 unsigned long long 	*crash_size,
> +				 unsigned long long 	*crash_base,
> +				 unsigned long 		system_ram)
> +{
> +	char *cur = cmdline;
> +
> +	*crash_size = 0;
> +	*crash_base = 0;
> +
> +	/* for each entry of the comma-separated list */
> +	do {
> +		unsigned long long start = 0, end = ULLONG_MAX;
> +		unsigned long long size = -1;
> +
> +		/* get the start of the range */
> +		start = memparse(cur, &cur);
> +		if (*cur != '-') {
> +			printk(KERN_WARNING "crashkernel: '-' expected\n");
> +			return -EINVAL;
> +		}
> +		cur++;
> +
> +		/* if no ':' is here, than we read the end */
> +		if (*cur != ':') {
> +			end = memparse(cur, &cur);
> +			if (end <= start) {
> +				printk(KERN_WARNING "crashkernel: end <= start\n");
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (*cur != ':') {
> +			printk(KERN_WARNING "crashkernel: ':' expected\n");
> +			return -EINVAL;
> +		}
> +		cur++;
> +
> +		size = memparse(cur, &cur);
> +		if (size < 0) {
> +			printk(KERN_WARNING "crashkernel: invalid size\n");
> +			return -EINVAL;
> +		}
> +
> +		/* match ? */
> +		if (system_ram >= start  && system_ram <= end) {
> +			*crash_size = size;
> +			break;
> +		}
> +	} while (*cur++ == ',');
> +
> +	if (*crash_size > 0) {
> +		while (*cur != ' ' && *cur != '@')
> +			cur++;
> +		if (*cur == '@')
> +			*crash_base = memparse(cur+1, &cur);

"offset" seems to be optional in the new syntax. What happens if user does
not specify offset. I think crash_base will be set to zero and system will
try to reserve x amount of memory start at zero? That would fail?

I think we should add some intelligence for automatic selection of "offset"
if user has not specified one. Automatically choose a chunk of free memory.
This takes away the headache from user for selecting a right place. In fact
one "offset" might not be valid for all the systems. I remember, somebody
had reported that ACPI tables were mapped lower in the address space and
reserving memory for kdump had failed.

Choosing the "offset" automatically should help distributions where one
command line is supposed to work on all the systems.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
