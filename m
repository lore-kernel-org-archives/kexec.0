Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f2QwJ-0001mZ-Q8
 for kexec@lists.infradead.org; Sun, 01 Apr 2018 00:33:45 +0000
Date: Sun, 1 Apr 2018 08:32:41 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] vmcore: __vmcore_add_device_dump() can be static
Message-ID: <20180401003241.GA77163@lkp-sb-ep06.lkp.intel.com>
References: <194d1e289b385f2cbd4cb2c2569af93723a9cfb8.1522483891.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <194d1e289b385f2cbd4cb2c2569af93723a9cfb8.1522483891.git.rahul.lakkireddy@chelsio.com>
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
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: ebiederm@xmission.com, indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, kbuild-all@01.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, viro@zeniv.linux.org.uk


Fixes: 6bf7e2b7f850 ("vmcore: add API to collect hardware dump in second kernel")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 vmcore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b53698f..fe788dd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1196,7 +1196,7 @@ static void vmcoredd_write_note(const char *name, void *buf, size_t size)
  * Write Elf note at the beginning of the buffer to indicate vmcore device
  * dump and add the dump to global list.
  */
-int __vmcore_add_device_dump(struct vmcoredd_data *data)
+static int __vmcore_add_device_dump(struct vmcoredd_data *data)
 {
 	size_t note_size, data_size;
 	struct vmcoredd_node *dump;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
