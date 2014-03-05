Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WL3sc-00021S-Tc
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 04:56:32 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 00/10] makedumpfile/eppic: Sample eppic scripts
Date: Wed, 5 Mar 2014 04:54:24 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F1ABE@BPXM01GP.gisp.nec.co.jp>
References: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
Content-Language: ja-JP
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
To: "aruna@linux.vnet.ibm.com" <aruna@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Aruna,

>The series has few sample eppic scripts to scrub the security
>data.
>
>
>---
>
>Aruna Balakrishnaiah (10):
>      Scrub executable name for each user process
>      Scrub filenames of cached dentries
>      Scrub all entries in the keyring
>      Clear the message data of all ap_bus requests
>      Scrub data in tcp socket buffers
>      Scrub data of udp socket buffers
>      Scrub data of unix socket buffers
>      Scrub socket buffers of guest network I/O
>      Scrub buffers involved in guest block I/O
>      Install sample eppic scripts

Great, they would be helpful for someone who want to try to use eppic !

I think it's better to write an abstract for each macro to
"eppic_scripts/README" since not all of the users refer to the git
repository.

It would also be helpful if you write the target kernel version of them
to the README because eppic macros are sensitive to kernel versions.


Thanks
Atsushi Kumagai

> Makefile                           |    1
> eppic_scripts/ap_messages.c        |   78 ++++++++++++++++++++++++++++++
> eppic_scripts/dir_names.c          |   78 ++++++++++++++++++++++++++++++
> eppic_scripts/keyring.c            |   57 ++++++++++++++++++++++
> eppic_scripts/proc_names.c         |   49 +++++++++++++++++++
> eppic_scripts/tcp_sk_buf.c         |   78 ++++++++++++++++++++++++++++++
> eppic_scripts/udp_sk_buf.c         |   79 ++++++++++++++++++++++++++++++
> eppic_scripts/unix_sk_buff.c       |   81 +++++++++++++++++++++++++++++++
> eppic_scripts/vhost_net_buffers.c  |   95 ++++++++++++++++++++++++++++++++++++
> eppic_scripts/vhost_scsi_buffers.c |   71 +++++++++++++++++++++++++++
> makedumpfile.spec                  |    3 +
> 11 files changed, 670 insertions(+)
> create mode 100644 eppic_scripts/ap_messages.c
> create mode 100644 eppic_scripts/dir_names.c
> create mode 100644 eppic_scripts/keyring.c
> create mode 100644 eppic_scripts/proc_names.c
> create mode 100644 eppic_scripts/tcp_sk_buf.c
> create mode 100644 eppic_scripts/udp_sk_buf.c
> create mode 100644 eppic_scripts/unix_sk_buff.c
> create mode 100644 eppic_scripts/vhost_net_buffers.c
> create mode 100644 eppic_scripts/vhost_scsi_buffers.c
>
>--
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
