Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dftHY-000889-Hs
 for kexec@lists.infradead.org; Thu, 10 Aug 2017 19:38:13 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A07DAFFC93
 for <kexec@lists.infradead.org>; Thu, 10 Aug 2017 19:30:24 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CD5D96593
 for <kexec@lists.infradead.org>; Thu, 10 Aug 2017 19:30:24 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com
 (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 833EF1805974
 for <kexec@lists.infradead.org>; Thu, 10 Aug 2017 19:30:24 +0000 (UTC)
Date: Thu, 10 Aug 2017 15:30:24 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1169006560.42893057.1502393424430.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.7.1502391602.4098.kexec@lists.infradead.org>
References: <mailman.7.1502391602.4098.kexec@lists.infradead.org>
Subject: Re: Re: [Makedumpfile PATCH v2] x86_64: Take care of
 init_level4_pgt rename in kernel
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
To: kexec@lists.infradead.org



----- Original Message -----
> 
> Ccing Dave, not sure if crash utility also need update about this
> issue..

Hi Pratyush,

Yes it does, I fixed it upstream a few weeks ago:

  commit a16324a2f05c0947a83e26a5de7c756de4603da9
  Author: Dave Anderson <anderson@redhat.com>
  Date:   Thu Jul 6 16:19:41 2017 -0400

    Fix for Linux 4.13-rc0 commit 7fd8329ba502ef76dd91db561c7aed696b2c7720
    "x86/boot/64: Rename init_level4_pgt and early_level4_pgt".  Without
    the patch, the crash session fails during initialization with the
    error message "crash: cannot resolve "init_level4_pgt".
    (anderson@redhat.com)

As well as a fix for the SECTION_MAP_MASK change:

  commit c24011916c6f70b3828ab522e3e6b0edb3c82677
  Author: Dave Anderson <anderson@redhat.com>
  Date:   Wed Jul 19 10:06:49 2017 -0400

    Fix for Linux 4.13-rc1 commit 2d070eab2e8270c8a84d480bb91e4f739315f03d
    "mm: consider zone which is not fully populated to have holes".
    Without the patch, SPARSEMEM page struct addresses are incorrectly
    calculated because a new section state, and an associated flag bit,
    has been added to the low bits of the mem_section.section_mem_map
    address; the extra bit is erroneously passed back as part of the
    section_mem_map and resultant page struct address, leading to
    errors in commands such as "kmem -p", "kmem -s", "kmem -n", and any
    other command that translates a physical address to its page struct
    address.
    (anderson@redhat.com)

I don't have support for 5-level paging as of yet.

Thanks,
  Dave

 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
