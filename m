Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aH5BS-00074b-73
 for kexec@lists.infradead.org; Thu, 07 Jan 2016 07:40:35 +0000
Date: Thu, 7 Jan 2016 13:10:10 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v2] arm64: Add support for 4level 4K page translations
 table
Message-ID: <20160107074010.GA6040@dhcppc13.redhat.com>
References: <1452123148-17792-1-git-send-email-asamson@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1452123148-17792-1-git-send-email-asamson@codeaurora.org>
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
To: Azriel Samson <asamson@codeaurora.org>
Cc: timur@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, Mansi Patel <mansip@codeaurora.org>, sgoel@codeaurora.org, virajm@codeaurora.org

Hi Azriel,

Thanks for the quick v2.

On 06/01/2016:04:32:28 PM, Azriel Samson wrote:
> Add PUD translation for 4 level page tables.
> 
> Signed-off-by: Mansi Patel <mansip@codeaurora.org>
> Signed-off-by: Azriel Samson <asamson@codeaurora.org>
> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
> ---
> This change targets the arm64_support branch of Pratush Anand's repository at:
> https://github.com/pratyushanand/makedumpfile.git

I have applied this patch to arm64_support branch. Since this patch depends on
few corresponding changes in kernel which is not part of Geoff's kexec-v12
series. So I will first get ACKed corresponding kernel patch [1] and then will
resend this patch along with other dependent patch to kexec mailing list.

~Pratyush

[1]
https://github.com/pratyushanand/linux/commit/3d9a2e96bd49c69637b88f61cbefa9736e029370

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
