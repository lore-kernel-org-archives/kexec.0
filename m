Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6PVK-000084-2H
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 22:13:31 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v1] Add in kexec -S for status,
 and add new Xen hypercall to support this.
Date: Mon, 14 Nov 2016 17:12:51 -0500
Message-Id: <1479161573-12671-1-git-send-email-konrad.wilk@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: david.vrabel@citrix.com, xen-devel@lists.xenproject.org, kexec@lists.infradead.org
Cc: elena.ufimtseva@oracle.com, daniel.kiper@oracle.com

Heya!

I am cross-posting on two mailing lists:
 xen-devel@lists.xenproject.org
 kexec@lists.infradead.org

as it may be easier to review and provide input then me going back and forth.

Anyhow the patches are to help with the various distro's poking in
/sys/../kexec to figure out whether an kexec image is loaded.

This can be done using the -S parameter now with the patch #2.

Also I add an hypercall to Xen so that if kexec is running under Xen
the same information can be retrieved (see patch #1).

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
