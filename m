Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJdFl-0003sg-Lk
 for kexec@lists.infradead.org; Thu, 25 Apr 2019 12:13:26 +0000
Received: by mail-ed1-x52b.google.com with SMTP id l25so1006931eda.9
 for <kexec@lists.infradead.org>; Thu, 25 Apr 2019 05:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190423204154.3085-1-pasha.tatashin@soleen.com>
 <20190425091019.4oqhaxfr6lug5zbo@verge.net.au>
In-Reply-To: <20190425091019.4oqhaxfr6lug5zbo@verge.net.au>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 25 Apr 2019 08:13:12 -0400
Message-ID: <CA+CK2bCrAMjRVG0RGbLwnD1ng7tH+u0EHoxHiJf-=KjqFigKKg@mail.gmail.com>
Subject: Re: [PATCH] kexec: quiet down kexec reboot
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
To: Simon Horman <horms@verge.net.au>
Cc: Sasha Levin <sashal@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, ebiederm@xmission.com

> > Machines that have slow console baud rate benefit from less output.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Simon Horman <horms@verge.net.au>
>

Thank you for reviewing.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
