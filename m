Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 4 May 2020 18:34:41 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] Documentation/vmcoreinfo: Add documentation for
 'KERNELPACMASK'
Message-ID: <20200504173440.GE1833@willie-the-truck>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <1587968702-19996-2-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1587968702-19996-2-git-send-email-amit.kachhap@arm.com>
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
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

On Mon, Apr 27, 2020 at 11:55:02AM +0530, Amit Daniel Kachhap wrote:
> Add documentation for KERNELPACMASK variable being added to the vmcoreinfo.
> 
> It indicates the PAC bits mask information of signed kernel pointers if
> Armv8.3-A Pointer Authentication feature is present.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 007a6b8..5cc3ee6 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -393,6 +393,12 @@ KERNELOFFSET
>  The kernel randomization offset. Used to compute the page offset. If
>  KASLR is disabled, this value is zero.
>  
> +KERNELPACMASK
> +-------------
> +
> +Indicates the PAC bits mask information if Pointer Authentication is
> +enabled and address authentication feature is present.

This is a bit cryptic. How about:

  The mask to extract the Pointer Authentication Code from a kernel virtual
  address.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
