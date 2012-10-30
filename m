Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from plane.gmane.org ([80.91.229.3])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TT06k-0003Dx-NC
 for kexec@lists.infradead.org; Tue, 30 Oct 2012 00:55:07 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glkk-kexec@m.gmane.org>) id 1TT06h-00053X-Va
 for kexec@lists.infradead.org; Tue, 30 Oct 2012 01:55:04 +0100
Received: from rtp5-dmz-wsa-2.cisco.com ([64.102.249.7])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Tue, 30 Oct 2012 01:55:03 +0100
Received: from joshua by rtp5-dmz-wsa-2.cisco.com with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Tue, 30 Oct 2012 01:55:03 +0100
From: Joshua Jensen <joshua@joshuajensen.org>
Subject: kexec-tools not loading iPXE zImage
Date: Tue, 30 Oct 2012 00:49:39 +0000 (UTC)
Message-ID: <loom.20121030T014113-581@post.gmane.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

I'm having an issue with kexec not being able to load a freshly compiled 
ipxe.lkrn file, even though it is a zImage:


# file ipxe.lkrn
ipxe.lkrn: Linux kernel x86 boot executable zImage, version \353FHdrS\007\002,RW-
rootFS,

# kexec -l ipxe.lkrn
Cannot determine the file type of ipxe.lkrn


Any ideas?  Is there any way to determine where the error is, with the ipxe.lkrn 
file or kexec ?

Thank you,

Joshua


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
