Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a5FnD-000328-19
 for kexec@lists.infradead.org; Sat, 05 Dec 2015 16:34:39 +0000
Subject: Re: [PATCH 3/4] arm64: Fix KVBASE
References: <cover.1449332470.git.panand@redhat.com>
 <3c83adde922e0ce26bafd8b189242b73fadbe40e.1449332470.git.panand@redhat.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56631206.9040500@codeaurora.org>
Date: Sat, 5 Dec 2015 10:34:14 -0600
MIME-Version: 1.0
In-Reply-To: <3c83adde922e0ce26bafd8b189242b73fadbe40e.1449332470.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>, ats-kumagai@wm.jp.nec.com
Cc: sgoel@codeaurora.org, dyoung@redhat.com, asamson@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org

Pratyush Anand wrote:
> +		& (0xffffffffffffffffUL << (VA_BITS - 1));

Shouldn't this be ULL instead of just UL?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
