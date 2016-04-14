Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqfzy-0003K3-3d
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 12:03:50 +0000
Date: Thu, 14 Apr 2016 20:03:21 +0800
From: Dave Young <dyoung@redhat.com>
Subject: kexec loading fails without kernel code address in /proc/iomem
Message-ID: <20160414120321.GA3502@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, zhezhang@redhat.com

Hi, Linus

Zhengyu Zhang <zhezhang@redhat.com> found a kexec failure caused by below commit:

commit c4004b02f8e5b9ce357a0bb1641756cc86962664
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Apr 6 13:45:07 2016 -0700

    x86: remove the kernel code/data/bss resources from /proc/iomem
    
    Let's see if anybody even notices.  I doubt anybody uses this, and it
    does expose addresses that should be randomized, so let's just remove
    the code.  It's old and traditional, and it used to be cute, but we
    should have removed this long ago.
    
    If it turns out anybody notices and this breaks something, we'll have to
    revert this, and maybe we'll end up using other approaches instead
    (using %pK or similar).  But removing unnecessary code is always the
    preferred option.
    
    Noted-by: Emrah Demir <ed@abdsec.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


Probably we should revert the commit and do it in other way ..

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
