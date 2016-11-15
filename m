Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6Vfe-0004e0-Sg
 for kexec@lists.infradead.org; Tue, 15 Nov 2016 04:48:35 +0000
Received: by mail-qt0-f170.google.com with SMTP id w33so61012418qtc.3
 for <kexec@lists.infradead.org>; Mon, 14 Nov 2016 20:48:14 -0800 (PST)
Subject: Re: [PATCH v1] Add in kexec -S for status, and add new Xen hypercall
 to support this.
References: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <08458dc9-bb87-2e0d-0a45-0526e186b125@redhat.com>
Date: Tue, 15 Nov 2016 10:18:02 +0530
MIME-Version: 1.0
In-Reply-To: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, david.vrabel@citrix.com, xen-devel@lists.xenproject.org, kexec@lists.infradead.org
Cc: elena.ufimtseva@oracle.com, daniel.kiper@oracle.com



On Tuesday 15 November 2016 03:42 AM, Konrad Rzeszutek Wilk wrote:
> Heya!
>
> I am cross-posting on two mailing lists:
>  xen-devel@lists.xenproject.org
>  kexec@lists.infradead.org
>
> as it may be easier to review and provide input then me going back and forth.

Hummmm..its confusing infact. Patch 1/2 does not belong to kexec-tools 
repository. patch 2/2 is independent in itself, so send 2/2 individually 
to kexec list and once it is getting acked, you can send only 1/2 to 
xen-devel list.


>
> Anyhow the patches are to help with the various distro's poking in
> /sys/../kexec to figure out whether an kexec image is loaded.
>
> This can be done using the -S parameter now with the patch #2.
>
> Also I add an hypercall to Xen so that if kexec is running under Xen
> the same information can be retrieved (see patch #1).

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
