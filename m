Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1US0h0-0007Zb-Jb
 for kexec@lists.infradead.org; Tue, 16 Apr 2013 07:52:43 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
Date: Tue, 16 Apr 2013 09:52:36 +0200
Message-ID: <8993037.v16xiECWWu@skinner.arch.suse.de>
In-Reply-To: <516C5B07.4010306@zytor.com>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <2503756.Y82nn6164B@hammer82.arch.suse.de> <516C5B07.4010306@zytor.com>
MIME-Version: 1.0
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, yinghai@kernel.org, cpw@sgi.com, vgoyal@redhat.com

On Monday, April 15, 2013 12:54:47 PM H. Peter Anvin wrote:
> On 04/15/2013 12:48 PM, Thomas Renninger wrote:
> > On Monday, April 15, 2013 05:20:24 AM H. Peter Anvin wrote:
> >> Except that is wrong. The kernel can receive more than 128 e820 entries,
> >> they just have to be passed via a different mechanism.

But you do not name/describe it.
Is it the "efi map mechanism" you are talking about or is there
something else?

      Thomas

> > Would it make sense to pass the tables via efi_map by moving up
> > efi_map parsing to the beginning of efi init in
> > arch/x86/platform/efi/efi.c?
> > 
> > And in kexec pass the efi signature, efi map pointers, add add_efi_memmap
> > param (and possibly some more?)?
> > Then there would be no limit at all anymore.
> 
> There is no limit... that's what I'm telling you.
 
> kexec should certainly pass the EFI information, otherwise the second
> kernel can't invoke EFI runtime calls at all.  Therein lies a whole bit
> of pain.
> 
> 	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
