Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a5p6s-0002Tt-0B
 for kexec@lists.infradead.org; Mon, 07 Dec 2015 06:17:18 +0000
Date: Mon, 7 Dec 2015 11:46:53 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH 3/4] arm64: Fix KVBASE
Message-ID: <20151207061653.GC16406@dhcppc13.redhat.com>
References: <cover.1449332470.git.panand@redhat.com>
 <3c83adde922e0ce26bafd8b189242b73fadbe40e.1449332470.git.panand@redhat.com>
 <56631206.9040500@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56631206.9040500@codeaurora.org>
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
To: Timur Tabi <timur@codeaurora.org>
Cc: ats-kumagai@wm.jp.nec.com, asamson@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, sgoel@codeaurora.org, dyoung@redhat.com

Hi Timur,

Thanks for your review.

On 05/12/2015:10:34:14 AM, Timur Tabi wrote:
> Pratyush Anand wrote:
> >+		& (0xffffffffffffffffUL << (VA_BITS - 1));
> 
> Shouldn't this be ULL instead of just UL?

I think on 64 bit platform, unsigned long is always 64 bit (with gcc). More
over, info->page_offset is unsigned long. So, I think using UL would be in sync,
no?

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
