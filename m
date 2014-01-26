Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-db3ln0101.outbound.protection.outlook.com
 ([2a01:111:f400:7e04::101]
 helo=emea01-db3-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W7KiM-0007UR-97
 for kexec@lists.infradead.org; Sun, 26 Jan 2014 08:05:14 +0000
Message-ID: <52E4C198.9010505@kaminario.com>
Date: Sun, 26 Jan 2014 10:04:40 +0200
From: "shahar.salzman@kaminario.com" <shahar.salzman@kaminario.com>
MIME-Version: 1.0
Subject: Crash kernel to dump specific pages
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Eran Mann <eran.mann@kaminario.com>, open-source-contrib@kaminario.com

Hi all,

We have been using the CentOS kexec (currently 2.0.0) as our recovery 
plan for kernel panic, up to now only dumping the dmesg.
Since we are using a server with a large amount of RAM, we are reluctant 
to perform a full memory dump, both in terms of the time it will take to 
return from the crash kernel, and in terms of disk space reservation.

Recently we where in need of a tweak to kexec so that one of our 
journals will be able to be saved when there is a kernel panic.
I implemented what I call a "raw PFN dump" which receives as input a 
file containing physical frames, and their contiguous length, and will 
dump this "scatter gather" as raw data.

This allows us to perform the following cycle:
1. Setup the journal
2. Get the physical memory mappings (using /proc/<self ot PID>/maps and 
/proc/<self or PID>/pagemap).
3. Format the physical memory mappings to a list of "PFN range" file
4. Add the file to the kdump.conf in the extra_bins
5. restart the kdump service
6. Activate the journal

I have tested this numerous times with CentOS6.4 and kexec-tools2.0.0 
(with makedumpfile 1.3.5).

Would you be interested in this feature for kdump?
If so, over which version should I rebase the patch?

Shahar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
