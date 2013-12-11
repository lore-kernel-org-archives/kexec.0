Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vqj31-0002Kg-57
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 12:37:52 +0000
Date: Wed, 11 Dec 2013 12:37:23 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v5 00/14] kexec kernel efi runtime support
Message-ID: <20131211123723.GC29980@console-pimps.org>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <20131210152549.7975e3ac25d854e2ada63221@linux-foundation.org>
 <20131210233207.GI31437@pd.tnic> <52A7A5D9.9030504@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52A7A5D9.9030504@zytor.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Tue, 10 Dec, at 03:38:01PM, H. Peter Anvin wrote:
> My intent was to pick them into a separate branch of the tip tree either
> directly or via Matt (since Matt feeds us anyway.)
> 
> But yes, work is still underway, although it is getting there.

Yeah, I've only found a few minor nits this time. I'll merge this soon -
presumably after the next revision.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
