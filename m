Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYDy7-0008TY-4x
 for kexec@lists.infradead.org; Fri, 22 Nov 2019 18:47:49 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 705D7800054
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2019 18:47:40 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64D8761074
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2019 18:47:40 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com
 (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5837F18095FF
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2019 18:47:40 +0000 (UTC)
Date: Fri, 22 Nov 2019 13:47:40 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <483111234.14383042.1574448460262.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.13491.1574446920.2486.kexec@lists.infradead.org>
References: <mailman.13491.1574446920.2486.kexec@lists.infradead.org>
Subject: Re: [PATCH v4 0/4] makedumpfile/arm64: Add support for ARMv8.2
 extensions
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



----- Original Message -----
> 
> Hi Bhupesh,
> 
> I recall seeing a reference to modification are needed for the crash CLI also
> to support 5.4.0-rc with your kernel patches cited here.
>  
> Where would I find that at ?  I don?t see crash on Giblab.

https://github.com/crash-utility/crash

> 
> >>> 
> >>> 
> >>> Hi
> >>> 
> >>> 
> >>> I was able to fork and clone your work area .
> >>> 
> >>> I can see makedumpfile works now !
> >>> 
> >>> Fantastic ;;  Thank you for your patience !
> >>> 
> >> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
