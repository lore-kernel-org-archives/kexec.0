Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WHxwE-0001QF-SB
 for kexec@lists.infradead.org; Mon, 24 Feb 2014 15:59:27 +0000
Date: Mon, 24 Feb 2014 10:59:02 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/4] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140224155902.GG4631@redhat.com>
References: <1392888512-4473-1-git-send-email-chaowang@redhat.com>
 <20140224145841.GE1262@dhcp-17-89.nay.redhat.com>
 <20140224152205.GC4631@redhat.com> <1972414.2B2S29ZK0k@skinner>
 <20140224154518.GE4631@redhat.com>
 <f0e5bc8f-8771-4faa-86a1-a46120a9aa1f@email.android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0e5bc8f-8771-4faa-86a1-a46120a9aa1f@email.android.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, jdmason@kudzu.us, dyoung@redhat.com, Thomas Renninger <trenn@suse.de>, WANG Chao <chaowang@redhat.com>

On Mon, Feb 24, 2014 at 07:50:19AM -0800, H. Peter Anvin wrote:
> Not just SGI, I don't think. You definitely need to do this.

Ok. Once we have resolved the calgary issue and merged the patches
where kdump memory ranges are passed in bootparams, we can take care
of passing reserved ranges too. One thing at a time.

Solving calgary issue is important though as this has been blocking
new patches for quite some time now.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
