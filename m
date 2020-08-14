Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6hKC-0006KJ-D0
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 21:33:21 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH][next] docs: vmcoreinfo: add lockless printk ringbuffer
 vmcoreinfo
Date: Fri, 14 Aug 2020 23:39:16 +0206
Message-Id: <20200814213316.6394-1-john.ogness@linutronix.de>
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
To: Baoquan He <bhe@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Nick Desaulniers <ndesaulniers@google.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-doc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

With the introduction of the lockless printk ringbuffer, the
VMCOREINFO relating to the kernel log buffer was changed. Update the
documentation to match those changes.

Fixes: ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
---
 based on next-20200814

 .../admin-guide/kdump/vmcoreinfo.rst          | 131 ++++++++++++++----
 1 file changed, 102 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 2baad0bfb09d..eb116905c31c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -189,50 +189,123 @@ from this.
 Free areas descriptor. User-space tools use this value to iterate the
 free_area ranges. MAX_ORDER is used by the zone buddy allocator.
 
-log_first_idx
+prb
+---
+
+A pointer to the printk ringbuffer (struct printk_ringbuffer). This
+may be pointing to the static boot ringbuffer or the dynamically
+allocated ringbuffer, depending on when the the core dump occurred.
+Used by user-space tools to read the active kernel log buffer.
+
+printk_rb_static
+----------------
+
+A pointer to the static boot printk ringbuffer. If @prb has a
+different value, this is useful for viewing the initial boot messages,
+which may have been overwritten in the dynamically allocated
+ringbuffer.
+
+clear_seq
+---------
+
+The sequence number of the printk() record after the last clear
+command. It indicates the first record after the last
+SYSLOG_ACTION_CLEAR, like issued by 'dmesg -c'. Used by user-space
+tools to dump a subset of the dmesg log.
+
+printk_ringbuffer
+-----------------
+
+The size of a printk_ringbuffer structure. This structure contains all
+information required for accessing the various components of the
+kernel log buffer.
+
+(printk_ringbuffer, desc_ring|text_data_ring|dict_data_ring|fail)
+-----------------------------------------------------------------
+
+Offsets for the various components of the printk ringbuffer. Used by
+user-space tools to view the kernel log buffer without requiring the
+declaration of the structure.
+
+prb_desc_ring
 -------------
 
-Index of the first record stored in the buffer log_buf. Used by
-user-space tools to read the strings in the log_buf.
+The size of the prb_desc_ring structure. This structure contains
+information about the set of record descriptors.
 
-log_buf
--------
+(prb_desc_ring, count_bits|descs|head_id|tail_id)
+-------------------------------------------------
+
+Offsets for the fields describing the set of record descriptors. Used
+by user-space tools to be able to traverse the descriptors without
+requiring the declaration of the structure.
+
+prb_desc
+--------
+
+The size of the prb_desc structure. This structure contains
+information about a single record descriptor.
+
+(prb_desc, info|state_var|text_blk_lpos|dict_blk_lpos)
+------------------------------------------------------
+
+Offsets for the fields describing a record descriptors. Used by
+user-space tools to be able to read descriptors without requiring
+the declaration of the structure.
+
+prb_data_blk_lpos
+-----------------
+
+The size of the prb_data_blk_lpos structure. This structure contains
+information about where the text or dictionary data (data block) is
+located within the respective data ring.
+
+(prb_data_blk_lpos, begin|next)
+-------------------------------
 
-Console output is written to the ring buffer log_buf at index
-log_first_idx. Used to get the kernel log.
+Offsets for the fields describing the location of a data block. Used
+by user-space tools to be able to locate data blocks without
+requiring the declaration of the structure.
 
-log_buf_len
+printk_info
 -----------
 
-log_buf's length.
+The size of the printk_info structure. This structure contains all
+the meta-data for a record.
 
-clear_idx
----------
+(printk_info, seq|ts_nsec|text_len|dict_len|caller_id)
+------------------------------------------------------
 
-The index that the next printk() record to read after the last clear
-command. It indicates the first record after the last SYSLOG_ACTION
-_CLEAR, like issued by 'dmesg -c'. Used by user-space tools to dump
-the dmesg log.
+Offsets for the fields providing the meta-data for a record. Used by
+user-space tools to be able to read the information without requiring
+the declaration of the structure.
 
-log_next_idx
-------------
+prb_data_ring
+-------------
 
-The index of the next record to store in the buffer log_buf. Used to
-compute the index of the current buffer position.
+The size of the prb_data_ring structure. This structure contains
+information about a set of data blocks.
 
-printk_log
-----------
+(prb_data_ring, size_bits|data|head_lpos|tail_lpos)
+---------------------------------------------------
 
-The size of a structure printk_log. Used to compute the size of
-messages, and extract dmesg log. It encapsulates header information for
-log_buf, such as timestamp, syslog level, etc.
+Offsets for the fields describing a set of data blocks. Used by
+user-space tools to be able to access the data blocks without
+requiring the declaration of the structure.
 
-(printk_log, ts_nsec|len|text_len|dict_len)
--------------------------------------------
+atomic_long_t
+-------------
+
+The size of the atomic_long_t structure. Used by user-space tools to
+be able to copy the full structure, regardless of its
+architecture-specific implementation.
+
+(atomic_long_t, counter)
+------------------------
 
-It represents field offsets in struct printk_log. User space tools
-parse it and check whether the values of printk_log's members have been
-changed.
+Offset for the long value of an atomic_long_t variable. Used by
+user-space tools to access the long value without requiring the
+architecture-specific declaration.
 
 (free_area.free_list, MIGRATE_TYPES)
 ------------------------------------
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
