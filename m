Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0aIK-0002ff-88
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 16:13:52 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
Date: Wed, 30 Jan 2013 17:13:43 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
 <201301301703.42601.trenn@suse.de>
In-Reply-To: <201301301703.42601.trenn@suse.de>
MIME-Version: 1.0
Message-Id: <201301301713.43946.trenn@suse.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: yinghai@kernel.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, x86@kernel.org, vgoyal@redhat.com

The sent patches are against latest x86-tip origin/mm2 branch
(3.8.0-rc5) based.

Please consider to apply them to x86-tip.
I will then resend the kexec-tools adjustings to the kexec
list with the same people in CC as in this one.

Thanks,

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
