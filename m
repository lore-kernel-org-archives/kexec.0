Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KdnDh-00006w-JI
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 14:32:29 +0000
Received: from zorg.emea.sgi.com (zorg.emea.sgi.com [144.253.68.115])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 211438F8113
	for <kexec@lists.infradead.org>; Thu, 11 Sep 2008 07:32:28 -0700 (PDT)
Received: from hedi by zorg.emea.sgi.com with local (Exim 4.63)
	(envelope-from <hedi@sgi.com>) id 1KdnDe-00007X-DK
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 15:32:26 +0100
Date: Thu, 11 Sep 2008 15:32:26 +0100
From: Hedi Berriche <hedi@sgi.com>
Subject: Re: the exiting makedumpfile is almost there... :)
Message-ID: <20080911143226.GT29908@sgi.com>
References: <48C85836.8080606@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48C85836.8080606@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Thu, Sep 11, 2008 at 00:29 Jay Lan wrote:
| a4700rac:/boot # date; makedumpfile -c -d31 -x
| /boot/vmlinux-2.6.27-rc5-default /proc/vmcore
| /mnt/sda9/diskdump/vmcore-2.6.27-rc5-default; date
| Wed Sep 10 14:31:56 PDT 2008
| Can't distinguish the pgtable.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| The kernel version is not supported.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| The created dumpfile may be incomplete.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| Copying data                       : [100 %]

Jay,

In addition to what other folks have mentioned about giving the latest crash
version a try, I'd like to point out that makedumpfile did spit a couple of
warnings while creating the vmcore


| Can't distinguish the pgtable.
| The kernel version is not supported.
| The created dumpfile may be incomplete.

these warnings added to the fact that later on crash choked with

| NOTE: page_hash_table does not exist in this kernel
| crash: page excluded: kernel virtual address: e000006003108e00  type:

seem to suggest that the makedumpfile warnings could be relevant to the
end result.

One useful experiment would be to find out whether a makdedumpfile generated
vmcore, from the one you saved with cp, does exhibit the same problem.

Cheers,
Hedi.
-- 
Hedi Berriche
GPS Unix
http://www.sgi.com/support

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
