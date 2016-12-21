Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJdn2-0002ky-K0
 for kexec@lists.infradead.org; Wed, 21 Dec 2016 10:06:30 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBLA3ikw102041
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:06 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27fnb2ffkf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:06 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 20:06:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DE3C82BB0045
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:05:57 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBLA5vpA51577082
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:05:57 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBLA5vHr013511
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:05:57 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/4] eppic: Create kernel version compatible scripts
Date: Wed, 21 Dec 2016 15:35:41 +0530
Message-Id: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org
Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

This patch series creates eppic scripts a for range kernel versions
they are compatible with. Eppic scripts directory host sample
scripts to scrub sensitive information from the dump file generated
using makedumpfile.

The initial version of these scripts was based on Fedora 19 kernel.
In brief, these scripts rely on hard coded kernel data structure
member offsets. Kernel data structures are bound to change in due course
and leading to failure when assumptions about the offsets differ.

Atsushi-San suggested that, it's better to have different version of
eppic scripts, those will be valid for the range of kernel release and
their naming convention hinting, of the release they are valid across.

The first patch renames the existing eppic script to reflect the kernel
release they are compatible with. Following the format:
<eppic_script>-<valid from kernel version>_to_<valid until kernel version>.c

Rest of three patches creates new eppic scripts to match with the kernel
data structures they work with.

Kamalesh Babulal (4):
  eppic: Rename scripts to reflect validity of kernel version
  eppic/vhost_net_buffers: Introduce changes for kernel 3.19
  eppic/dir_names: Introduce changes for kernel 3.14
  eppic/keyring: Introduce changes for kernel 4.4

 eppic_scripts/README                           |  26 +-
 eppic_scripts/ap_messages.c                    |  82 ------
 eppic_scripts/ap_messages_3_10_to_4_8.c        |  82 ++++++
 eppic_scripts/dir_names.c                      |  78 -----
 eppic_scripts/dir_names_3_10_to_3_13.c         |  78 +++++
 eppic_scripts/dir_names_3_14_to_4_8.c          |  82 ++++++
 eppic_scripts/keyring.c                        |  57 ----
 eppic_scripts/keyring_3_10_to_4_3.c            |  57 ++++
 eppic_scripts/keyring_4_4_to_4_8.c             | 378 +++++++++++++++++++++++++
 eppic_scripts/proc_names.c                     |  49 ----
 eppic_scripts/proc_names_3_10_to_4_8.c         |  49 ++++
 eppic_scripts/tcp_sk_buf.c                     |  82 ------
 eppic_scripts/tcp_sk_buf_3_10_to_4_8.c         |  82 ++++++
 eppic_scripts/udp_sk_buf.c                     |  83 ------
 eppic_scripts/udp_sk_buf_3_10_to_4_8.c         |  83 ++++++
 eppic_scripts/unix_sk_buff.c                   |  85 ------
 eppic_scripts/unix_sk_buff_3_10_to_4_8.c       |  85 ++++++
 eppic_scripts/vhost_net_buffers.c              |  99 -------
 eppic_scripts/vhost_net_buffers_3_10_to_3_18.c |  99 +++++++
 eppic_scripts/vhost_net_buffers_3_19_to_4_8.c  | 104 +++++++
 eppic_scripts/vhost_scsi_buffers.c             |  75 -----
 eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c |  75 +++++
 22 files changed, 1270 insertions(+), 700 deletions(-)
 delete mode 100644 eppic_scripts/ap_messages.c
 create mode 100644 eppic_scripts/ap_messages_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/dir_names.c
 create mode 100644 eppic_scripts/dir_names_3_10_to_3_13.c
 create mode 100644 eppic_scripts/dir_names_3_14_to_4_8.c
 delete mode 100644 eppic_scripts/keyring.c
 create mode 100644 eppic_scripts/keyring_3_10_to_4_3.c
 create mode 100644 eppic_scripts/keyring_4_4_to_4_8.c
 delete mode 100644 eppic_scripts/proc_names.c
 create mode 100644 eppic_scripts/proc_names_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/tcp_sk_buf.c
 create mode 100644 eppic_scripts/tcp_sk_buf_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/udp_sk_buf.c
 create mode 100644 eppic_scripts/udp_sk_buf_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/unix_sk_buff.c
 create mode 100644 eppic_scripts/unix_sk_buff_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/vhost_net_buffers.c
 create mode 100644 eppic_scripts/vhost_net_buffers_3_10_to_3_18.c
 create mode 100644 eppic_scripts/vhost_net_buffers_3_19_to_4_8.c
 delete mode 100644 eppic_scripts/vhost_scsi_buffers.c
 create mode 100644 eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
