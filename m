Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kytHE-00069C-Bp
 for kexec@lists.infradead.org; Mon, 11 Jan 2021 09:14:17 +0000
Date: Mon, 11 Jan 2021 10:13:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <X/wWnGF5ajYk0bf4@kroah.com>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108033248.GA4959@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: lijiang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Egorenkov <egorenar@linux.ibm.com>, ktkhai@virtuozzo.com, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, christian.brauner@ubuntu.com, vgoyal@redhat.com, keescook@chromium.org

On Fri, Jan 08, 2021 at 11:32:48AM +0800, Baoquan He wrote:
> On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > The offset of the field 'init_uts_ns.name' has changed
> > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
> 
> This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> commit 9a56493f6942 is merged into 5.9-rc2.
> 
> Below tag and CC should have been added into patch when posted. 
> 
> Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
> Cc: <stable@vger.kernel.org>
> 
> Hi Greg,
> 
> Do we still have chance to make it added into stable?

Wait, 9a56493f6942 ("uts: Use generic ns_common::count") is in 5.11-rc1,
and this commit fixes that one, so why does anything need to be
backported?

Are you _SURE_ that this commit is needed in 5.10.y?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
