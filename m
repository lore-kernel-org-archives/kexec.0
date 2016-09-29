Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpW8n-0007kJ-Ja
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 07:52:27 +0000
Date: Thu, 29 Sep 2016 09:52:00 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 0/8] (kexec-tools) arm64: add kdump support
Message-ID: <20160929075200.GE14497@verge.net.au>
References: <20160907043401.6403-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160907043401.6403-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org

On Wed, Sep 07, 2016 at 01:33:53PM +0900, AKASHI Takahiro wrote:
> My kernel patches of kdump suport on arm64 are currently under reviews.
> 
> This patchset is synced with them (v26 [1]) and provides necessary changes
> for kexec-tools. It should be applied on top of Geoff's kexec-tools patches
> v5[2] along with a bugfix[3].
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/454588.html
> [2] http://lists.infradead.org/pipermail/kexec/2016-September/017110.html
> [3] http://lists.infradead.org/pipermail/kexec/2016-July/016664.html

Unfortunately patch 2 does not seem to apply cleanly any more.
Could you consider rebasing if you think this series is ready to be
applied?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
