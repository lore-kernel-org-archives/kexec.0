From: Baoquan He <bhe@redhat.com>
Date: Mon, 18 Apr 2022 09:40:36 +0800
Subject: [PATCH v6 1/4] kexec: clean up arch_kexec_kernel_verify_sig
In-Reply-To: <20220415093735.74eusyuuboa32aqs@Rk>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-2-coxu@redhat.com>
 <YleYmZAAnF5aOan3@MiWiFi-R3L-srv>
 <20220415093735.74eusyuuboa32aqs@Rk>
Message-ID: <YlzBlPWXWeg6ABen@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/15/22 at 05:37pm, Coiby Xu wrote:
> On Thu, Apr 14, 2022 at 11:44:25AM +0800, Baoquan He wrote:
> > On 04/14/22 at 09:43am, Coiby Xu wrote:
> > > Currently there is no arch-specific implementation of
> > > arch_kexec_kernel_verify_sig. Even if we want to add an implementation
> > > for an architecture in the future, we can simply use "(struct
> > > kexec_file_ops*)->verify_sig". So clean it up.
> > > 
> > > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> > > Cc: stable at kernel.org
> > 
> > It should be not worth noticing stable kernel that a clean up patch need
> > be back ported.
> 
> Thanks for the suggestion! For the 2nd and 3rd patch, I'll add prerequisite
> info,
> 
> Cc: stable at kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
> 
> and
> 
> Cc: stable at kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
> Cc: stable at kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
> 
> respectively.

That sounds good, thx.


