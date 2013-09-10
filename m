Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJWc1-000482-DM
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 22:40:46 +0000
Date: Tue, 10 Sep 2013 15:40:09 -0700
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 14/16] kexec: Export sysfs attributes for secureboot and
 secure modules to user space
Message-ID: <20130910224009.GA23727@kroah.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-15-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1378849471-10521-15-git-send-email-vgoyal@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com

On Tue, Sep 10, 2013 at 05:44:29PM -0400, Vivek Goyal wrote:
> User space kexec-tools need to know whether to verify signature of kernel
> image being loaded. This patch exports two knobs to user space. One is
> for knowing if  secureboot is enabled, this knob will be set to 1 if secure
> boot is enabled. Other knob is secure_module_enabled. This knob will be set
> to 1 if secure modules is one.
> 
> kexec-tools will verify signature of kernel image if either secureboot is
> enabled or secure modules is enabled. The only difference between two is
> that kexec-tools will set secureboot on in bootparams being passed to
> second kernel if secureboot is on in first kernel.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  kernel/ksysfs.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Minor nit, if you add/modify/delete sysfs files, you also have to update
Documentation/ABI/ with the information about those files.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
