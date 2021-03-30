Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLtZ-004vfH-93
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:32 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 26/43] mm: shmem: specify the mm to use when inserting pages
Date: Tue, 30 Mar 2021 14:36:01 -0700
Message-Id: <1617140178-8773-27-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

Explicitly specify the mm to pass to shmem_insert_page() when
the pkram_stream is initialized rather than use the mm of the
current thread.  This will allow for multiple kernel threads to
target the same mm when inserting pages in parallel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 904b1b861ce5..8682b0c002c0 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -225,7 +225,7 @@ int shmem_save_pkram(struct super_block *sb)
 	return err;
 }
 
-static int load_file_content(struct pkram_stream *ps, struct address_space *mapping)
+static int load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
 {
 	PKRAM_ACCESS(pa, ps, pages);
 	unsigned long index;
@@ -237,7 +237,7 @@ static int load_file_content(struct pkram_stream *ps, struct address_space *mapp
 		if (!page)
 			break;
 
-		err = shmem_insert_page(current->mm, mapping->host, index, page);
+		err = shmem_insert_page(mm, mapping->host, index, page);
 		put_page(page);
 		cond_resched();
 	} while (!err);
@@ -291,7 +291,7 @@ static int load_file(struct dentry *parent, struct pkram_stream *ps,
 	inode->i_ctime = ns_to_timespec64(hdr.ctime);
 	i_size_write(inode, hdr.size);
 
-	err = load_file_content(ps, inode->i_mapping);
+	err = load_file_content(ps, inode->i_mapping, current->mm);
 out_unlock:
 	inode_unlock(d_inode(parent));
 out:
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
