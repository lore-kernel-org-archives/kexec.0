Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URpQ2-0004R4-Hs
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 19:50:27 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
Date: Mon, 15 Apr 2013 21:48:58 +0200
Message-ID: <2503756.Y82nn6164B@hammer82.arch.suse.de>
In-Reply-To: <be30cb86-285f-4ff0-af0d-ea7d18a3490c@email.android.com>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <2471280.iW0sCiTc3x@skinner.arch.suse.de>
 <be30cb86-285f-4ff0-af0d-ea7d18a3490c@email.android.com>
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

On Monday, April 15, 2013 05:20:24 AM H. Peter Anvin wrote:
> Except that is wrong. The kernel can receive more than 128 e820 entries,
> they just have to be passed via a different mechanism.

Would it make sense to pass the tables via efi_map by moving up
efi_map parsing to the beginning of efi init in arch/x86/platform/efi/efi.c?

And in kexec pass the efi signature, efi map pointers, add add_efi_memmap
param (and possibly some more?)?
Then there would be no limit at all anymore.


     Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
