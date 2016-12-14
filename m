Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail5.windriver.com ([192.103.53.11] helo=mail5.wrs.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH65S-0001lK-NA
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 09:42:59 +0000
From: He Zhe <zhe.he@windriver.com>
Subject: Need help for arm64
Message-ID: <800dfe9c-02cf-def8-0cb6-8469553d6d00@windriver.com>
Date: Wed, 14 Dec 2016 17:42:38 +0800
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
To: geoff@infradead.org, kexec@lists.infradead.org
Cc: Yang Shi <yang.shi@windriver.com>

Hi,

I notice the function below in kexec/arch/arm64/crashdump-arm64.c. It looks it always causes "kexec -p" to return:
"Memory for crashkernel is not reserved
Please reserve memory by passing"crashkernel=X@Y" parameter to kernel
Then try to loading kdump kernel"

int is_crashkernel_mem_reserved(void)                                           
{                                                                               
        return 0;                                                               
}

Do we have plan to implement this?
Do we have workaround for arm64?

Thanks,
Zhe


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
