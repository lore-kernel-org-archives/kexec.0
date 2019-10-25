Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNqTl-00029C-9t
 for kexec@lists.infradead.org; Fri, 25 Oct 2019 03:41:34 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20191023141912.29110-1-lijiang@redhat.com>
 <20191023141912.29110-2-lijiang@redhat.com>
 <20191024100719.GC11441@verge.net.au>
 <4c1c4b78-23f0-a2b9-4be7-5bab0335f10a@redhat.com>
 <6da13645-c5e9-6c95-1f2d-bede177f9863@redhat.com>
 <OSBPR01MB40062E08DFAEDA628FDC945895650@OSBPR01MB4006.jpnprd01.prod.outlook.com>
 <2020bbf9-67b2-52e8-756f-b595414b4c02@redhat.com>
Date: Thu, 24 Oct 2019 22:39:59 -0500
In-Reply-To: <2020bbf9-67b2-52e8-756f-b595414b4c02@redhat.com> (lijiang's
 message of "Fri, 25 Oct 2019 11:14:43 +0800")
Message-ID: <875zkdtrw0.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2 v5] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: lijiang <lijiang@redhat.com>
Cc: "jgross@suse.com" <jgross@suse.com>, "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>, "bhe@redhat.com" <bhe@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dhowells@redhat.com" <dhowells@redhat.com>, Simon Horman <horms@verge.net.au>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

lijiang <lijiang@redhat.com> writes:

>  * Returns the length of the argument (regardless of if it was
>  * truncated to fit in the buffer), or -1 on not found.
>  */
> static int
> __cmdline_find_option(const char *cmdline, int max_cmdline_size,
>                       const char *option, char *buffer, int bufsize)
>
>
> According to the above code comment, it should be better like this:
>
> +       if (cmdline_find_option(boot_command_line, "crashkernel",
> +                               NULL, 0) > 0) {
>
> After i test, i will post again.
>

This seems reasonable as we are dealing with x86 only code.

It wound be nice if someone could generalize cmdline_find_option to be
arch independent so that crash_core.c:parse_crashkernel could use it.
I don't think for this patchset, but it looks like an overdue cleanup.

We run the risk with parse_crashkernel using strstr and this using
another algorithm of having different kernel command line parsers
giving different results and disagreeing if "crashkernel=" is present
or not on the kernel command line.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
