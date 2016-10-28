Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH V2] arm64: Add support of R_AARCH64_PREL32 relocation in
 purgatory
References: <f970f7938109c40833fc45e3d6d72b1dcdf14595.1477627895.git.panand@redhat.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <3175f823-dd03-07f6-fffe-6ec5487cbf93@infradead.org>
Date: Fri, 28 Oct 2016 11:43:48 -0700
MIME-Version: 1.0
In-Reply-To: <f970f7938109c40833fc45e3d6d72b1dcdf14595.1477627895.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, horms@verge.net.au
Cc: catalin.marinas@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 10/27/2016 09:16 PM, Pratyush Anand wrote:
> gcc version in fedora koji is  6.2.1-2.fc25. kexec-tools compiled with this
> gcc produced another relocation error:
> 
> machine_apply_elf_rel: ERROR Unknown type: 261
> 
> This patch fixes the above error.

Looks good.  Simon, please apply.

Reviewed-by: Geoff Levand <geoff@infradead.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
