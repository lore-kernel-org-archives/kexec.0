Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W5TZ7-0002UL-HJ
 for kexec@lists.infradead.org; Tue, 21 Jan 2014 05:07:59 +0000
Date: Tue, 21 Jan 2014 14:07:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 0/4] kexec-tools: efi runtime support on kexec kernel
Message-ID: <20140121050729.GA5152@verge.net.au>
References: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
 <20140121025536.GA5544@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140121025536.GA5544@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, Jan 21, 2014 at 10:55:36AM +0800, Dave Young wrote:
> Hi, Simon
> 
> The kernel patches has been merged into Linus tree, could you take a look
> at these kexec-tools patches and merge them if there's no more comments?
> 
> Patch 4/4 was resended in a reply to original 4/4, the subject is:
> [PATCH v4 4/4 update] Passing efi related data via setup_data
> These patches has been tested by Toshi Kani <toshi.kani@hp.com>
> 
> If you need I resend them please let me know.

Thanks Dave,

I have applied the four patches.
Please double check to make sure that I got the correct version
of each patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
