Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bScfE-0006mL-Tz
 for kexec@lists.infradead.org; Thu, 28 Jul 2016 04:11:17 +0000
Received: by mail-pf0-f180.google.com with SMTP id y134so17496247pfg.0
 for <kexec@lists.infradead.org>; Wed, 27 Jul 2016 21:10:56 -0700 (PDT)
Date: Thu, 28 Jul 2016 09:40:53 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v2 3/4] arm64: Add arm64 kexec support
Message-ID: <20160728041053.GB27150@localhost.localdomain>
References: <cover.1469559530.git.geoff@infradead.org>
 <fbb0f30aa1493b40c53264c9b5ae62b46606bd61.1469559530.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fbb0f30aa1493b40c53264c9b5ae62b46606bd61.1469559530.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 26/07/2016:08:18:57 PM, Geoff Levand wrote:
> Add kexec reboot support for ARM64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---

[...]

> +
> +#define OPT_APPEND		((OPT_MAX)+0)
> +#define OPT_DTB			((OPT_MAX)+1)
> +#define OPT_INITRD		((OPT_MAX)+2)
> +#define OPT_REUSE_CMDLINE	((OPT_MAX)+4)

Option count 3 is missing. 

> +#define OPT_ARCH_MAX		((OPT_MAX)+5)

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
