Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFDMB-0007eY-PY
 for kexec@lists.infradead.org; Wed, 24 Oct 2018 07:13:33 +0000
Date: Wed, 24 Oct 2018 15:13:10 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] arm64: If 'getrandom' syscall fails, don't error out -
 just warn and proceed.
Message-ID: <20181024071310.GA2120@MiWiFi-R3L-srv>
References: <1540239620-29321-1-git-send-email-bhsharma@redhat.com>
 <20181023013145.GA10791@dhcp-128-65.nay.redhat.com>
 <CACi5LpPxqqc93YT9_444g0J+WwiO1sy1a_rKYq8wtV=zKr+wwA@mail.gmail.com>
 <20181024070439.GC3094@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181024070439.GC3094@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh Sharma <bhsharma@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>

On 10/24/18 at 03:04pm, Dave Young wrote:
> But if one specify "nokaslr" in 2nd kernel cmdlind eg. in some kdump
> config files, but kexec-tools still give a warning message, this is not
> good.

Yeah, message is an element of feature. If adding nokaslr still give a
warning or error message, that is obviously a bug we need fix. Otherwise
we can step back to not support kaslr in kdump.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
