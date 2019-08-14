Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxwuj-0003Pz-L2
 for kexec@lists.infradead.org; Wed, 14 Aug 2019 17:18:22 +0000
Received: by mail-oi1-x235.google.com with SMTP id p124so4826298oig.5
 for <kexec@lists.infradead.org>; Wed, 14 Aug 2019 10:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
 <20190813192126.122370-4-matthewgarrett@google.com>
 <20190814052359.GA10664@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190814052359.GA10664@dhcp-128-65.nay.redhat.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 14 Aug 2019 10:18:07 -0700
Message-ID: <CACdnJuuG8vy37KaoXHU-bzr-VLEwnUWWiCH_zKWuvYdGDDAV5A@mail.gmail.com>
Subject: Re: [PATCH 3/6] Avoid build warning when !CONFIG_KEXEC_SIG
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
Cc: Jiri Bohac <jbohac@suse.cz>, LSM List <linux-security-module@vger.kernel.org>, kexec devel list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>

On Tue, Aug 13, 2019 at 10:24 PM Dave Young <dyoung@redhat.com> wrote:

> I can not get the whole thread, also not sure which tree it should
> apply.

This should be against -next.

> Also I think it should be good to split the preparation piece of kexec
> and send them separately.  Since it is improve the signature
> verification logic, they do not necessarily depend on the lockdown
> series.

Sorry, which preparation piece? There shouldn't be any logic change in
this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
