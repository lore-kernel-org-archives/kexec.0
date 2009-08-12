Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MbEIN-0006Wl-8g
	for kexec@lists.infradead.org; Wed, 12 Aug 2009 13:55:19 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7CDtD81014280
	for <kexec@lists.infradead.org>; Wed, 12 Aug 2009 09:55:13 -0400
Received: from mail05.corp.redhat.com (zmail05.collab.prod.int.phx2.redhat.com
	[10.5.5.46])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n7CDtBPb030636
	for <kexec@lists.infradead.org>; Wed, 12 Aug 2009 09:55:12 -0400
Date: Wed, 12 Aug 2009 09:55:11 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2137018006.1822011250085311758.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <OF3BE32408.A37213B3-ON65257610.002173CE-65257610.0021C659@tcs.com>
Subject: Fwd: vmcore file size 0 on x86_64
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


Forwarding to kexec list.

  http://lists.infradead.org/mailman/listinfo/kexec


----- Forwarded Message -----
From: "Chandan12 K" <chandan12.k@tcs.com>
To: Crash-utility@redhat.com
Sent: Wednesday, August 12, 2009 2:08:54 AM GMT -05:00 US/Canada Eastern
Subject: [Crash-utility] vmcore file size 0 on x86_64



Hi, 

I am little new in this mailing list. I just wondered if anybody could help me regarding the vmcore file generation. I ran kexec on my x86_64 machine, and the /proc/vmcore file is created with zero size. 

However, even if I read the /dev/oldmem file, I am only able to read till 16M. I guess I am only able to read till the 'X', where X is crashkernel=Y@X. 

Moreover, My machine seems to have 32 bit user space and ofcourse, 64 bit kernel space. 

Appreciate any response. 

Chandan Kumar 
____________________________________________ =====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you 
--
Crash-utility mailing list
Crash-utility@redhat.com
https://www.redhat.com/mailman/listinfo/crash-utility

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
