Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V9h21-00049L-0A
 for kexec@lists.infradead.org; Wed, 14 Aug 2013 19:46:57 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5200BFB3.2050202@jp.fujitsu.com> <520A10A3.5080303@hp.com>
 <520B4A22.2030800@hp.com>
Date: Wed, 14 Aug 2013 12:45:54 -0700
In-Reply-To: <520B4A22.2030800@hp.com> (Jingbai Ma's message of "Wed, 14 Aug
 2013 17:13:06 +0800")
Message-ID: <87ob90839p.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [Help Test] kdump, x86,
 acpi: Reproduce CPU0 SMI corruption issue after unsetting BSP flag
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Mitchell,
 Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com, Vivek Goyal <vgoyal@redhat.com>

Jingbai Ma <jingbai.ma@hp.com> writes:

> I found a side effect of unsetting BSP flag.
> It affected system rebooting, once the BSP flags been removed, and issue
> reboot command, system will hang after message:
> Restarting system.
> And have to do a hardware reset to recover it.
>
> I have reproduced this problem on the following systems:
> HP EliteBook 6930p
> HP Compaq DC7700
> HP ProLiant DL980 (4 sockets, 40 cores)
>
> I have an idea: To avoid such kind of issue, we can unset BSP flag in
> the first kernel during crash processing, and restore it in the second
> kernel in the APs initializing.

The premise was clearing BSP would not be an issue.  If we could
reliably count on unsetting the BSP during crash processing we could
just switch to the BSP and be done totally avoid this problem.

Given that there are reald world issues with clearing the BSP flag,
I believe the alternate suggestion was to simply never attempt to start
the bootstrap processor during processor bring up.

If as normal we are running on the bootstrap processor everything will
work the same, but if we are in the kdump scenario we will be short one
core.  Being short one core seems like a reasonable tradeoff between
reliability and performance.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
