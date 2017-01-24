Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cW1Iv-0006IR-6V
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 13:38:34 +0000
Date: Tue, 24 Jan 2017 14:38:06 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3] kexec: Increase the upper limit for RAM segments
Message-ID: <20170124133806.GE28325@verge.net.au>
References: <1484781312-22420-1-git-send-email-sgoel@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1484781312-22420-1-git-send-email-sgoel@codeaurora.org>
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
To: Sameer Goel <sgoel@codeaurora.org>
Cc: geoff@infradead.org, kexec@lists.infradead.org, xlpang@redhat.com, bhe@redhat.com

On Wed, Jan 18, 2017 at 04:15:12PM -0700, Sameer Goel wrote:
> On a newer UEFI based Qualcomm target the number of system ram regions
> retrieved from /proc/iomem are ~40. So increasing the current hardcoded
> values to 64 from 16.
> 
> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
