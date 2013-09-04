Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VH6KI-00041K-6O
 for kexec@lists.infradead.org; Wed, 04 Sep 2013 06:12:27 +0000
Date: Wed, 4 Sep 2013 08:12:22 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86, apic: Disable BSP if boot cpu is AP
Message-ID: <20130904061221.GA17791@x1.alien8.de>
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <20130829092804.5476.95588.stgit@localhost6.localdomain6>
 <20130831052252.GC12617@x1.alien8.de>
 <5223F8DB.3040506@jp.fujitsu.com>
 <20130902071318.GA3406@x1.alien8.de>
 <52245D94.5050702@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52245D94.5050702@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

On Mon, Sep 02, 2013 at 06:42:44PM +0900, HATAYAMA Daisuke wrote:
> The reason why I don't lookup BSP flag in MSR is that it's impossible.
> To read MSR of some CPU, we need to use rdmsr instruction on the CPU.
> However, in case of this issue, the BSP is halting or running in
> the kdump 1st kernel.

Yes, and on the AP, that flag would be cleared which makes it not a BSP.

> A whole explanation is written in the patch description.

Those tend to get lost in git history when a bunch of whitespace jerk
offs appear ontop. So a nicely written comment in the code could be very
helpful.

Thanks.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
