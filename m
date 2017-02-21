Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cgGWG-0005dT-31
 for kexec@lists.infradead.org; Tue, 21 Feb 2017 19:54:42 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v1LJsGmw003642
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2017 19:54:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v1LJsGRl010906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2017 19:54:16 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v1LJsEKb001435
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2017 19:54:15 GMT
Subject: Re: [PATCH v2] gitignore: add two generated files in purgatory
References: <1487693904-10324-1-git-send-email-eric.devolder@oracle.com>
 <20170221194801.GB3484@olila.local.net-space.pl>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <92bd5303-7517-4419-25ae-3dead53afdb8@oracle.com>
Date: Tue, 21 Feb 2017 13:54:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170221194801.GB3484@olila.local.net-space.pl>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


On 02/21/2017 01:48 PM, Daniel Kiper wrote:
> On Tue, Feb 21, 2017 at 10:18:24AM -0600, Eric DeVolder wrote:
>> This patch adds the two generated files below to .gitignore,
>> so that 'git status' does not complain about them.
>
> This is not a problem. Do you have issues during 'git checkout'
> or so? If yes then I think it is worth considering.
>
> Daniel

The contents of .gitignore are as follows. There are other generated 
files in the file list. It's not that there is a problem, but rather I 
added these two files for the likely same reason the other generated 
files are in the list, to cease the complaints from git about those files.

eric

=== contents of .gitignore ===

#
# Normal rules
#
*~
*.a
*.d
*.o
*.ro

# generated files
/Makefile
/autom4te.cache/
/bin/
/build/
/config.log
/config.status
/configure
/include/config.h.in
/include/config.h


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
