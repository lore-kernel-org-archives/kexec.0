Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMctC-00089V-0Z
 for kexec@lists.infradead.org; Mon, 01 Apr 2013 11:27:06 +0000
Message-ID: <51596F03.2050603@nod.at>
Date: Mon, 01 Apr 2013 13:26:59 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] [RFC] get rid of dist
References: <1364815385-26722-1-git-send-email-richard@nod.at>
 <1364815385-26722-2-git-send-email-richard@nod.at>
In-Reply-To: <1364815385-26722-2-git-send-email-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: zhangyanfei@cn.fujitsu.com, horms@verge.net.au, kexec@lists.infradead.org

Am 01.04.2013 13:23, schrieb Richard Weinberger:
> -SRCS:= $(dist)
> +SRCS:= $(call git ls-files) configure include/config.h include/config.h.in \
> +	kexec/purgatory.c kexec-tools.spec

*grrr*, s/call/shell/g

A new patch is on the way.

Thanks,
//richard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
