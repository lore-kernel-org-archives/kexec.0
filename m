Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cLkMI-0007UH-Op
 for kexec@lists.infradead.org; Tue, 27 Dec 2016 05:31:36 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [RFC PATCH 0/4] eppic: Create kernel version compatible scripts
Date: Tue, 27 Dec 2016 05:22:19 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E8EBE7@BPXM01GP.gisp.nec.co.jp>
References: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
In-Reply-To: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Kamalesh,

>This patch series creates eppic scripts a for range kernel versions
>they are compatible with. Eppic scripts directory host sample
>scripts to scrub sensitive information from the dump file generated
>using makedumpfile.
>
>The initial version of these scripts was based on Fedora 19 kernel.
>In brief, these scripts rely on hard coded kernel data structure
>member offsets. Kernel data structures are bound to change in due course
>and leading to failure when assumptions about the offsets differ.
>
>Atsushi-San suggested that, it's better to have different version of
>eppic scripts, those will be valid for the range of kernel release and
>their naming convention hinting, of the release they are valid across.
>
>The first patch renames the existing eppic script to reflect the kernel
>release they are compatible with. Following the format:
><eppic_script>-<valid from kernel version>_to_<valid until kernel version>.c
>
>Rest of three patches creates new eppic scripts to match with the kernel
>data structures they work with.

Thank you for reflecting my comments, looks good to me.
v1.6.1 is ready now, these patches will be merged into v1.6.2.

Thanks,
Atsushi Kumagai

>Kamalesh Babulal (4):
>  eppic: Rename scripts to reflect validity of kernel version
>  eppic/vhost_net_buffers: Introduce changes for kernel 3.19
>  eppic/dir_names: Introduce changes for kernel 3.14
>  eppic/keyring: Introduce changes for kernel 4.4
>
> eppic_scripts/README                           |  26 +-
> eppic_scripts/ap_messages.c                    |  82 ------
> eppic_scripts/ap_messages_3_10_to_4_8.c        |  82 ++++++
> eppic_scripts/dir_names.c                      |  78 -----
> eppic_scripts/dir_names_3_10_to_3_13.c         |  78 +++++
> eppic_scripts/dir_names_3_14_to_4_8.c          |  82 ++++++
> eppic_scripts/keyring.c                        |  57 ----
> eppic_scripts/keyring_3_10_to_4_3.c            |  57 ++++
> eppic_scripts/keyring_4_4_to_4_8.c             | 378 +++++++++++++++++++++++++
> eppic_scripts/proc_names.c                     |  49 ----
> eppic_scripts/proc_names_3_10_to_4_8.c         |  49 ++++
> eppic_scripts/tcp_sk_buf.c                     |  82 ------
> eppic_scripts/tcp_sk_buf_3_10_to_4_8.c         |  82 ++++++
> eppic_scripts/udp_sk_buf.c                     |  83 ------
> eppic_scripts/udp_sk_buf_3_10_to_4_8.c         |  83 ++++++
> eppic_scripts/unix_sk_buff.c                   |  85 ------
> eppic_scripts/unix_sk_buff_3_10_to_4_8.c       |  85 ++++++
> eppic_scripts/vhost_net_buffers.c              |  99 -------
> eppic_scripts/vhost_net_buffers_3_10_to_3_18.c |  99 +++++++
> eppic_scripts/vhost_net_buffers_3_19_to_4_8.c  | 104 +++++++
> eppic_scripts/vhost_scsi_buffers.c             |  75 -----
> eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c |  75 +++++
> 22 files changed, 1270 insertions(+), 700 deletions(-)
> delete mode 100644 eppic_scripts/ap_messages.c
> create mode 100644 eppic_scripts/ap_messages_3_10_to_4_8.c
> delete mode 100644 eppic_scripts/dir_names.c
> create mode 100644 eppic_scripts/dir_names_3_10_to_3_13.c
> create mode 100644 eppic_scripts/dir_names_3_14_to_4_8.c
> delete mode 100644 eppic_scripts/keyring.c
> create mode 100644 eppic_scripts/keyring_3_10_to_4_3.c
> create mode 100644 eppic_scripts/keyring_4_4_to_4_8.c
> delete mode 100644 eppic_scripts/proc_names.c
> create mode 100644 eppic_scripts/proc_names_3_10_to_4_8.c
> delete mode 100644 eppic_scripts/tcp_sk_buf.c
> create mode 100644 eppic_scripts/tcp_sk_buf_3_10_to_4_8.c
> delete mode 100644 eppic_scripts/udp_sk_buf.c
> create mode 100644 eppic_scripts/udp_sk_buf_3_10_to_4_8.c
> delete mode 100644 eppic_scripts/unix_sk_buff.c
> create mode 100644 eppic_scripts/unix_sk_buff_3_10_to_4_8.c
> delete mode 100644 eppic_scripts/vhost_net_buffers.c
> create mode 100644 eppic_scripts/vhost_net_buffers_3_10_to_3_18.c
> create mode 100644 eppic_scripts/vhost_net_buffers_3_19_to_4_8.c
> delete mode 100644 eppic_scripts/vhost_scsi_buffers.c
> create mode 100644 eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c
>
>--
>2.7.4
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
