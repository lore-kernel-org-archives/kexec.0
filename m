Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
From: Seiji Aguchi <seiji.aguchi@hds.com>
Date: Tue, 19 Jul 2011 14:23:26 -0400
Subject: [RFC][PATCH -mmotm 0/4] Improvement of pstore/kmsg_dump in
	kexec/panic path
Message-ID: <5C4C569E8A4B9B42A84A977CF070A35B2C199C64C2@USINDEVS01.corp.hds.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Eric W.
	Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Americo Wang <xiyou.wangcong@gmail.com>, Matthew Garrett <mjg@redhat.com>, "tony.luck@intel.com" <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jarod Wilson <jwilson@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "dzickus@redhat.com" <dzickus@redhat.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, Satoru Moriya <satoru.moriya@hds.com>

Hi,

[Upstream status]
   Discussion about kmsg_dump() in kdump path: 
    - Eric and Vivek are worried about reliability of existing kmsg_dump().
    - Especially, Vivek would like to remove a RCU  function call chain in kdump path
　　　 which kernel modules can register their function calls freely. 

   Discussion about pstore in nmi_hander.
    - Don Zickus found an issue of pstore in nmi_handler due to its mutex_lock.
    

[Build Status]
  Built this patch on 3.0.0-rc6-mm1 in x86_64.

[Patch Description]

 For meeting Eric/Vivek's requirements and solving an issue of pstore in nmi_hander due to mutex_lock,
 I propose following patches.

  [RFC][PATCH -mmotm 1/4] Add static function calls of pstore to kexec path

        Some people who are not familiar with kexec may add function calls getting 
        spin_lock/mutex_lock in kexec path. These function calls causes failure of kexec. 
        So, I suggest replace a call chain with static function calls so that we can keep 
        reliability of kexec.

        APEI storage backend will work well in kexec path by applying this patch.

        Summary of this patch:
        - Call pstore_kmsg_dump_in_interrupt() directly in kexec path
        - Remove mutex_lock in pstore_dump() of kexec path

  [RFC][PATCH -mmotm 2/4] Remove mutex_lock from pstore in panic path

        Pstore must not take mutex_lock in panic path as well as kexec path 
        because panic() is called in interrupt context like nmi_handler.
        APEI storage backend will work well in panic path with this patch.

        Summary of this patch:
        - Remove kmsg_dump(KMSG_DUMP_PANIC)
        - Call pstore_kmsg_dump_in_interrupt() directly in panic path
        - Remove mutex_lock in pstore_dump() of panic path

  [RFC][PATCH -mmotm 3/4] pstore: mtdoops support

        - Pstore can support mtdoops with this patch.

  [RFC][PATCH -mmotm 4/4] pstore: ramoops support

        - Pstore can support ramoops with this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
