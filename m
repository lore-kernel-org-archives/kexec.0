Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wtp6K-0002Vx-BY
 for kexec@lists.infradead.org; Mon, 09 Jun 2014 02:14:21 +0000
Date: Mon, 9 Jun 2014 10:15:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.7
Message-ID: <20140609021537.GC1924@darkstar.nay.redhat.com>
References: <20140609010134.GA25776@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140609010134.GA25776@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 06/09/14 at 10:01am, Simon Horman wrote:
> Hi all,
> 
> I am happy to announce the release of kexec-tools 2.0.7.

Simon,

Thanks for the new release.

FYI, the efi kernel patch has been merged into 3.15 kernel:
commit a3530e8fe980f756b823d451fe9243f26db95fa5
Author: Dave Young <dyoung@redhat.com>
Date:   Fri May 30 11:20:10 2014 +0800

    x86/efi: Do not export efi runtime map in case old map
    
    For ioremapped efi memory aka old_map the virt addresses are not persistant
    across kexec reboot. kexec-tools will read the runtime maps from sysfs then
    pass them to 2nd kernel and assuming kexec efi boot is ok. This will cause
    kexec boot failure.
    
    To address this issue do not export runtime maps in case efi old_map so
    userspace can use no efi boot instead.
    
    Signed-off-by: Dave Young <dyoung@redhat.com>
    Acked-by: Borislav Petkov <bp@suse.de>
    Acked-by: Vivek Goyal <vgoyal@redhat.com>
    Signed-off-by: Matt Fleming <matt.fleming@intel.com>

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
