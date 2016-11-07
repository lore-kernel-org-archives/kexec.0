Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 7 Nov 2016 09:14:33 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] arm64: Add support of R_AARCH64_PREL32 relocation in
 purgatory
Message-ID: <20161107081433.GB13099@verge.net.au>
References: <f970f7938109c40833fc45e3d6d72b1dcdf14595.1477627895.git.panand@redhat.com>
 <3175f823-dd03-07f6-fffe-6ec5487cbf93@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3175f823-dd03-07f6-fffe-6ec5487cbf93@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Pratyush Anand <panand@redhat.com>, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Oct 28, 2016 at 11:43:48AM -0700, Geoff Levand wrote:
> On 10/27/2016 09:16 PM, Pratyush Anand wrote:
> > gcc version in fedora koji is  6.2.1-2.fc25. kexec-tools compiled with this
> > gcc produced another relocation error:
> > 
> > machine_apply_elf_rel: ERROR Unknown type: 261
> > 
> > This patch fixes the above error.
> 
> Looks good.  Simon, please apply.
> 
> Reviewed-by: Geoff Levand <geoff@infradead.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
