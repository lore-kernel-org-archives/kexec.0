Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjfGg-0002Gc-LF
 for kexec@lists.infradead.org; Fri, 03 Mar 2017 04:56:41 +0000
Received: by mail-pg0-f46.google.com with SMTP id s67so39803160pgb.3
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 20:56:18 -0800 (PST)
Subject: Re: [Makedumpfile Patch v3 7/7] mem-usage: allow to work only with -f
 for kernel version < 4.11
References: <cover.1488443170.git.panand@redhat.com>
 <6689d9cf1e69f79b0e8c74ecab8e003e5507a79b.1488443170.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EAABEE@BPXM01GP.gisp.nec.co.jp>
 <3b32aab8-0cbe-fb9a-f884-3b0713717aca@redhat.com> <20170303030735.GB24001@x1>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EAAE77@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <5f10b643-bc47-e4a4-bd3d-7f0c7b8adf68@redhat.com>
Date: Fri, 3 Mar 2017 10:26:12 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EAAE77@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "bhe@redhat.com" <bhe@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Friday 03 March 2017 10:05 AM, Atsushi Kumagai wrote:
> When you change the design, please note it into changelog,
> it's a review point of view.
>
>   Changes since v2:
>     - Fixed a memory leak issue and updated man page and usage info

Sorry about that!!

>
> As for the return value, I guess both is OK if there is a clear intention.
> If this is what you intended, I have no objection.
> (it actually sounds more reasonable)
>
> So I'll merge the v3 patch into v1.6.2, thanks for your work.


and thanks :-)


~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
