Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuVI-0001yW-Ob
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:31:34 +0000
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 12:01:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 76903394004E
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:01 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6V3YQ28770512
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:03 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6V06F017024
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:00 +0530
Subject: [PATCH 00/10] makedumpfile/eppic: Sample eppic scripts
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:00 +0530
Message-ID: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

The series has few sample eppic scripts to scrub the security
data.


---

Aruna Balakrishnaiah (10):
      Scrub executable name for each user process
      Scrub filenames of cached dentries
      Scrub all entries in the keyring
      Clear the message data of all ap_bus requests
      Scrub data in tcp socket buffers
      Scrub data of udp socket buffers
      Scrub data of unix socket buffers
      Scrub socket buffers of guest network I/O
      Scrub buffers involved in guest block I/O
      Install sample eppic scripts


 Makefile                           |    1 
 eppic_scripts/ap_messages.c        |   78 ++++++++++++++++++++++++++++++
 eppic_scripts/dir_names.c          |   78 ++++++++++++++++++++++++++++++
 eppic_scripts/keyring.c            |   57 ++++++++++++++++++++++
 eppic_scripts/proc_names.c         |   49 +++++++++++++++++++
 eppic_scripts/tcp_sk_buf.c         |   78 ++++++++++++++++++++++++++++++
 eppic_scripts/udp_sk_buf.c         |   79 ++++++++++++++++++++++++++++++
 eppic_scripts/unix_sk_buff.c       |   81 +++++++++++++++++++++++++++++++
 eppic_scripts/vhost_net_buffers.c  |   95 ++++++++++++++++++++++++++++++++++++
 eppic_scripts/vhost_scsi_buffers.c |   71 +++++++++++++++++++++++++++
 makedumpfile.spec                  |    3 +
 11 files changed, 670 insertions(+)
 create mode 100644 eppic_scripts/ap_messages.c
 create mode 100644 eppic_scripts/dir_names.c
 create mode 100644 eppic_scripts/keyring.c
 create mode 100644 eppic_scripts/proc_names.c
 create mode 100644 eppic_scripts/tcp_sk_buf.c
 create mode 100644 eppic_scripts/udp_sk_buf.c
 create mode 100644 eppic_scripts/unix_sk_buff.c
 create mode 100644 eppic_scripts/vhost_net_buffers.c
 create mode 100644 eppic_scripts/vhost_scsi_buffers.c

-- 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
