Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jS3vm-0000ra-CQ
 for kexec@lists.infradead.org; Fri, 24 Apr 2020 19:24:12 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAD7E107ACCD
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 19:24:00 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A33975C1D0
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 19:24:00 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com
 (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9C3774CA94
 for <kexec@lists.infradead.org>; Fri, 24 Apr 2020 19:24:00 +0000 (UTC)
Date: Fri, 24 Apr 2020 15:24:00 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <289396508.24991092.1587756240556.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.7.1587754804.31179.kexec@lists.infradead.org>
References: <mailman.7.1587754804.31179.kexec@lists.infradead.org>
Subject: Re: [crash - Question ] mod -s <module>  not working with
 compressed modules
MIME-Version: 1.0
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
To: kexec@lists.infradead.org



----- Original Message ----
> 
> Hi
> 
>  I observed that  loading module symbols from a compressed ko.xz  ( crash 7.2.3-10.el7 ) does not work,
> and the desired module has to be un-compressed . Does anyone know if there is a recent patch that addresses this ?

Nope.


> 
> 
> Example:
> 
> Modules are located at the mod path :
> 
> crash -s  `find kernel-uek-debuginfo-4.14.35-1902.302.1.01.el7uek.rc1 -name vmlinux ` vmcore --mod ./kernel-uek-4.14.35-1902.302.1.01.tst17059_u3.el7uek.rc1/lib/modules/4.14.35-1902.302.1.01.el7uek.rc1.x86_64/kernel/
> 
> 
> crash> mod -S
> mod: cannot find or load object file for usb_storage module
> mod: cannot find or load object file for dca module
> mod: cannot find or load object file for fb_sys_fops module
> mod: cannot find or load object file for uas module
>      MODULE       NAME                     SIZE  OBJECT FILE
> ffffffffc07400c0  qla2xxx                794624
> ./kernel-uek-4.14.35-1902.302.1.01.el7uek.rc1/lib/modules/4.14.35-1902.302.1.01.el7uek.rc1.x86_64/kernel/drivers/scsi/qla2xxx/qla2xxx.ko
> 
> I un-compressed qla2xxx.ko.xz  so it was found.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
