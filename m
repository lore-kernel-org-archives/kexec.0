Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IFpO4-0000Iv-VN
	for kexec@lists.infradead.org; Tue, 31 Jul 2007 06:55:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731091004.GA2022@elf.ucw.cz>
	<1185873924.23149.86.camel@caritas-dev.intel.com>
Date: Tue, 31 Jul 2007 04:52:35 -0600
In-Reply-To: <1185873924.23149.86.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Tue, 31 Jul 2007 17:25:24 +0800")
Message-ID: <m17iogrgjw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

"Huang, Ying" <ying.huang@intel.com> writes:

> On Tue, 2007-07-31 at 11:10 +0200, Pavel Machek wrote:
>> > Index: kexec-tools-1.101/kexec/arch/i386/crashdump-x86.c
>> > ===================================================================
>> > --- kexec-tools-1.101.orig/kexec/arch/i386/crashdump-x86.c 2007-07-08
> 23:00:25.000000000 +0800
>> > +++ kexec-tools-1.101/kexec/arch/i386/crashdump-x86.c 2007-07-14
> 17:06:45.000000000 +0800
>> > @@ -428,6 +428,29 @@
>> >  	return 0;
>> >  }
>> >  
>> > +/* Adds the kexec_backup= command line parameter to command line. */
>> > +static int cmdline_add_backup(char *cmdline, unsigned long addr)
>> > +{
>> > +	int cmdlen, len, align = 1024;
>> > +	char str[30], *ptr;
>> > +
>> > +	/* Passing in kexec_backup=xxxK format. Saves space required
>> > +	 * in cmdline. Ensure 1K alignment*/
>> > +	if (addr%align)
>> > +		return -1;
>> > +	addr = addr/align;
>> > +	ptr = str;
>> > +	strcpy(str, " kexec_backup=");
>> > +	ptr += strlen(str);
>> > +	ultoa(addr, ptr);
>> > +	strcat(str, "K");
>> > +	len = strlen(str);
>> > +	cmdlen = strlen(cmdline) + len;
>> > +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
>> > +		die("Command line overflow\n");
>> > +	strcat(cmdline, str);
>> > +	return 0;
>> > +}
>> 
>> This part did not apply for me -- it seems crashdump related and I did
>> not have that applied. Is it critical?
>
> This is needed for kexec_jump to work properly. Which version of
> kexec-tools do you use? This patch is against 1.101. The kdump patch
> must be applied before this patch is applied.

Please work against the kexec-tools-testing tree, if you can.
All of the outstanding patches should be there.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
