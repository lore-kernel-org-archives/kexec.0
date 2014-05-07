Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wi67l-0004Md-Fm
 for kexec@lists.infradead.org; Wed, 07 May 2014 17:59:21 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s47HwxC6022373
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Wed, 7 May 2014 13:59:00 -0400
Date: Wed, 7 May 2014 13:58:58 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Why do we pass memory map both in e820 and efi_info
Message-ID: <20140507175858.GD21048@redhat.com>
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
To: Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Hi Dave/Chao,

I am going through kexec-tools code and it looks like that for EFI
systems, we pass memory map entries both in bootparams e820 memory map
as well as efi_info. I am wondering why that's the case?

IOW, I am also trying to figure out as a bootloader, when should we
pass memmap in e820 and when should it be passed in efi_info.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
