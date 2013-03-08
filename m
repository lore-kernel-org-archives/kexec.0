Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDuZh-0002RU-BC
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 10:30:59 +0000
Date: Fri, 8 Mar 2013 11:30:44 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 0/4] kexec-tools: add support for Xen 4.3
Message-ID: <20130308103044.GC10740@debian70-amd64.local.net-space.pl>
References: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, xen-devel@lists.xen.org

David,

I have done some tests. I will send my thoughts
and comments as reply to relevant emails.

On Thu, Feb 21, 2013 at 05:57:36PM +0000, David Vrabel wrote:
> The series adds support for the new hypercall ABI which should be
> provided by Xen 4.3.  Images are loaded into Xen directly with no
> kernel involvement.
>
> Do not apply until the hypervisor side patches are applied to Xen.
>
> Patch 1 is unrelated but kexec wouldn't work for me without it. Not
> sure why I had problems, perhaps a toolstack specific issue?
>
> Patch 2 makes libxc 4.3 mandatory for Xen support.
>
> Patch 3 removes a use of /proc/iomem in favour of libxc.
>
> Patch 4 adds the support for loading an image into Xen.
>
> This series explicitly drops support for older version of libxc/Xen as
> supporting kexec on these hypervisors requires kernel support that
> will never be available upstream.

Please do not do that. I agree with Jan that there are many
distros in the wild which uses old interface (and they will
be doing that long time) and we should not make their life
more difficult.

I have found that simple kexec does not work. It means that
if you call kexec -e (after kexec -l) it displays:

Nothing has been loaded!

Linux on baremetal works without any issue.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
