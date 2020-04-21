Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400074.outbound.protection.outlook.com
 ([40.107.140.74] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQwYe-0007k0-PZ
 for kexec@lists.infradead.org; Tue, 21 Apr 2020 17:19:42 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: [ANNOUNCE] makedumpfile: Moved to GitHub
Date: Tue, 21 Apr 2020 17:19:32 +0000
Message-ID: <OSBPR01MB19912B1799B8D12FFF70242CDDD50@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

The makedumpfile project page has moved to GitHub:
  https://github.com/makedumpfile/makedumpfile

To clone its repository:
  $ git clone https://github.com/makedumpfile/makedumpfile.git

As announced last week, the devel branch was removed and the master branch
serves as a development branch that will contain all patches that are queued
for the next release.

The SourceForge page will be kept as is for the old source archives.

Thanks,
Kazu

> -----Original Message-----
> Hi,
> 
> I'm going to move makedumpfile's project page [1] and git repository
> from SourcrForge to GitHub for several reasons.  I will announce it
> when the preparation is completed.
> 
> With this move, I plan to discontinue its 'devel' branch and use 'master'
> only.  We have not merged any hotfix directly into the master branch and
> distributions have backported patches in the devel branch into their trees.
> I don't think we make much use of the branch feature.  I'd like to simplify
> the process.
> 
> Please let me know if you have any concerns.
> 
> Although moving to GitHub, I continue to prefer you to post makedumpfile
> patches to this email list for reasons of a lot of good eyes.
> 
> [1] https://sourceforge.net/projects/makedumpfile/
> 
> Thanks,
> Kazu
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
