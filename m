Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxnRe-00065l-TD
 for kexec@lists.infradead.org; Fri, 08 Jan 2021 08:48:33 +0000
Date: Fri, 8 Jan 2021 16:48:16 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20210108084816.GB4959@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv> <X/gT6jQTaFkqqIGt@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/gT6jQTaFkqqIGt@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lijiang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Egorenkov <egorenar@linux.ibm.com>, ktkhai@virtuozzo.com, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, christian.brauner@ubuntu.com, vgoyal@redhat.com, keescook@chromium.org

On 01/08/21 at 09:12am, Greg KH wrote:
> On Fri, Jan 08, 2021 at 11:32:48AM +0800, Baoquan He wrote:
> > On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > > The offset of the field 'init_uts_ns.name' has changed
> > > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> > 
> > This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> > of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> > commit 9a56493f6942 is merged into 5.9-rc2.
> > 
> > Below tag and CC should have been added into patch when posted. 
> > 
> > Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
> > Cc: <stable@vger.kernel.org>
> > 
> > Hi Greg,
> > 
> > Do we still have chance to make it added into stable?
> 
> Sure, what is the git commit id of this patch in Linus's tree?

This commit:

ca4a9241cc5e kdump: append uts_namespace.name offset to VMCOREINFO

> 
> In the future, please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

Sure, will do as the doc said in the future, thanks a lot for the
pointer.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
