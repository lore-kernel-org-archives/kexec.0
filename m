Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.xenproject.org ([104.130.215.37])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvO4k-0004LW-Bf
 for kexec@lists.infradead.org; Tue, 14 Jul 2020 16:46:39 +0000
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <hx242@xen.org>) id 1jvO4h-0002Ms-OJ
 for kexec@lists.infradead.org; Tue, 14 Jul 2020 16:46:35 +0000
Received: from 54-240-197-224.amazon.com ([54.240.197.224]
 helo=iad7-dhcp-95-148-76.iad7.amazon.com)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <hx242@xen.org>) id 1jvO4h-00084H-Dy
 for kexec@lists.infradead.org; Tue, 14 Jul 2020 16:46:35 +0000
Message-ID: <af50ddc2d59995f6ca22f338d6761cb83ee69d36.camel@xen.org>
Subject: Return value of `kexec -S` under Xen
From: Hongyan Xia <hx242@xen.org>
Date: Tue, 14 Jul 2020 17:46:34 +0100
Mime-Version: 1.0
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

Hi,

I am working on kexec on top of Xen and just found something weird. The
man page says `kexec -S` returns 0 if the kernel is loaded, but on the
Xen side it returns 1 for a loaded kernel.

in xen/common/kexec.c, kexec_status():

1207     if ( kexec_load_get_bits(status.type, &base, &bit) )
1208         return -EINVAL;
1209 
1210     return !!test_bit(bit, &kexec_flags); // returns 1 when loaded

This caused quite a bit of confusion in my work before I figured out
what was going on. May I know why the code in Xen is like this? Thanks.

Hongyan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
