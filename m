Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcDje-00011K-Ab
 for kexec@lists.infradead.org; Tue, 23 Aug 2016 15:35:30 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7NFSqA1117613
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 11:35:08 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2502yx1ssv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 11:35:08 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 23 Aug 2016 12:35:06 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id CE6C0352006C
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 11:34:42 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7NFZ4mh4759706
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 12:35:04 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7NFZ33c007230
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 12:35:04 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [integrity:next-restore-kexec 18/31]
 include/linux/kexec.h:400:52: warning: 'struct kexec_buf' declared inside
 parameter list will not be visible outside of this definition or declaration
Date: Tue, 23 Aug 2016 12:34:59 -0300
In-Reply-To: <201608232256.6ONII0WZ%fengguang.wu@intel.com>
References: <201608232256.6ONII0WZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Message-Id: <1617934.na55SdnaSp@hactar>
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
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-ima-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, kexec@lists.infradead.org, kbuild-all@01.org

Am Dienstag, 23 August 2016, 22:17:59 schrieb kbuild test robot:
> tree:  
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> next-restore-kexec head:   62bc4b565254de4796a0835f6f67569eb4835f9f
> commit: f9f57350e53441210120931fc4e0163cf833e648 [18/31] kexec_file: Add
> buffer hand-over support for the next kernel config: i386-defconfig
> (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         git checkout f9f57350e53441210120931fc4e0163cf833e648
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/pci/pci-driver.c:22:0:
> >> include/linux/kexec.h:400:52: warning: 'struct kexec_buf' declared
> >> inside parameter list will not be visible outside of this definition
> >> or declaration
>     static inline int kexec_add_handover_buffer(struct kexec_buf *kbuf)

This happens when CONFIG_KEXEC=y but CONFIG_KEXEC_FILE=n, and is fixed by 
the following change, which will be in my next revision of the kexec
buffer hand-over series:

    Fix for "kexec_file: Add buffer hand-over support for the next kernel"
    
    Declare stub struct kexec_buf when CONFIG_KEXEC_FILE=n.

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6ec09e85efd9..29f98f816e92 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -404,6 +404,8 @@ int kexec_add_handover_buffer(struct kexec_buf *kbuf);
 int __weak kexec_get_handover_buffer(void **addr, unsigned long *size);
 int __weak kexec_free_handover_buffer(void);
 #else
+struct kexec_buf;
+
 static inline bool kexec_can_hand_over_buffer(void)
 {
 	return false;


-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
